//
//  ZHYResourceContainer.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 28/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceContainer.h"
#import "ZHYResourceWrapper.h"
#import "ZHYResourceKitDefines.h"
#import "ZHYLogger.h"

/* Resource Wrapper Valid Check Macro */

#define WRAPPER_NIL_CONDITION(wrapper)\
if (wrapper == nil) {\
    return;\
}\

#define WRAPPER_TYPE_CONDITION(wrapper)\
if (![self canAcceptResourceWrapper:wrapper]) {\
    ZHYLogWarning(@"'%@' can not add '%@' because of resource type not matched.", self, resourceWrapper);\
    return;\
}\

static NSString * const kZHYResourceContainerInfoFileName = @"info.plist";

@interface ZHYResourceContainer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceWrapper *> *wrappers;

@end

@implementation ZHYResourceContainer

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _wrappers = [NSMutableDictionary dictionary];
        
        _resourceType = [resourceType copy];
    }
    
    return self;
}

#pragma mark - Public Property

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    WRAPPER_NIL_CONDITION(resourceWrapper);
    WRAPPER_TYPE_CONDITION(resourceWrapper);
    
    ZHYResourceWrapper *conflictedWrapper = [self conflictedResourceWrapper:resourceWrapper dequeue:YES];
    id<ZHYResourceContainerDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(resourceContainer:willAddWrapper:conflictedWrapper:)]) {
        [delegate resourceContainer:self willAddWrapper:resourceWrapper conflictedWrapper:conflictedWrapper];
    }
    
    [self.wrappers setObject:resourceWrapper forKey:resourceWrapper.resourceName];
    
    if ([delegate respondsToSelector:@selector(resourceContainer:didAddWrapper:conflictedWrapper:)]) {
        [delegate resourceContainer:self didAddWrapper:resourceWrapper conflictedWrapper:conflictedWrapper];
    }
}

- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    WRAPPER_NIL_CONDITION(resourceWrapper);
    WRAPPER_TYPE_CONDITION(resourceWrapper);
    
    ZHYResourceWrapper *conflictedWrapper = [self conflictedResourceWrapper:resourceWrapper dequeue:NO];
    if (conflictedWrapper == nil) {
        return;
    }
    
    if (![resourceWrapper isEqual:conflictedWrapper]) {
        return;
    }
    
    id<ZHYResourceContainerDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(resourceContainer:willRemoveWrapper:)]) {
        [delegate resourceContainer:self willRemoveWrapper:conflictedWrapper];
    }
    
    [self.wrappers removeObjectForKey:conflictedWrapper.resourceName];
    
    id<ZHYResourceContainerDataSource> dataSource = self.dataSource;
    if ([dataSource respondsToSelector:@selector(contentPathOfContainer:)]) {
        NSString *contentPath = [dataSource contentPathOfContainer:self];
        if (contentPath != nil) {
            NSString *resourcePath = [contentPath stringByAppendingPathComponent:conflictedWrapper.resourceName];
            resourcePath = [resourcePath stringByAppendingPathExtension:kZHYResourceFilePathExtension];
            
            
        }
    }
    
    if ([delegate respondsToSelector:@selector(resourceContainer:didRemoveWrapper:)]) {
        [delegate resourceContainer:self didRemoveWrapper:conflictedWrapper];
    }
}



#pragma mark - Private Methods

+ (NSString *)filenameForWrapper:(ZHYResourceWrapper *)wrapper {
    NSString *resourceName = wrapper.resourceName;
    if (resourceName == nil) {
        return nil;
    }
    
    return [resourceName stringByAppendingPathExtension:kZHYResourceFilePathExtension];
}

- (BOOL)canAcceptResourceWrapper:(nonnull ZHYResourceWrapper *)wrapper {
    NSString *resourceType = wrapper.resourceType;
    return [self.resourceType isEqualToString:resourceType];
}

- (nullable ZHYResourceWrapper *)conflictedResourceWrapper:(nonnull ZHYResourceWrapper *)wrapper dequeue:(BOOL)dequeue {
    NSString *key = wrapper.resourceName;
    ZHYResourceWrapper *conflictedWrapper = [self.wrappers objectForKey:key];
    if (dequeue && conflictedWrapper != nil) {
        [self.wrappers removeObjectForKey:key];
    }
    
    return conflictedWrapper;
}

#pragma mark - Public Property

- (NSArray<ZHYResourceWrapper *> *)allResourceWrappers {
    return self.wrappers.allValues;
}

@end

/***** Info Keys *****/
static NSString * const kZHYResourceContainerInfoKeyType = @"resourceType";
static NSString * const kZHYResourceContainerInfoKeyVersion = @"version";

/* Info Values */
static NSInteger const kZHYResourceContainerInfoValueVersion = 1;

@implementation ZHYResourceContainer (Serializer)

- (BOOL)writeToContentPath:(NSString *)contentPath {
    if (contentPath == nil) {
        ZHYLogError(@"'%@' can not write to `nil` path.", self);
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL existed = [fileManager fileExistsAtPath:contentPath isDirectory:&isDirectory];
    
    if (existed && !isDirectory) {
        ZHYLogError(@"'%@' can not write to '%@' because of content path is an file.", self, contentPath);
        return NO;
    }
    
    if (!existed) {
        NSError *error = nil;
        if (![fileManager createDirectoryAtPath:contentPath withIntermediateDirectories:YES attributes:nil error:&error]) {
            ZHYLogError(@"'%@' create directory at '%@' failure. <error: %@>", error);
            return NO;
        }
    }
    
    NSMutableDictionary<NSString *, id> *infos = [NSMutableDictionary dictionaryWithCapacity:2];
    [infos setObject:@(kZHYResourceContainerInfoValueVersion) forKey:kZHYResourceContainerInfoKeyVersion];
    [infos setObject:self.resourceType forKey:kZHYResourceContainerInfoKeyType];
    
    NSString *infosFilePath = [contentPath stringByAppendingString:kZHYResourceContainerInfoFileName];
    if (![infos writeToFile:infosFilePath atomically:YES]) {
        ZHYLogError(@"'%@' write infos file failure.", self);
        return NO;
    }
    
    NSArray<ZHYResourceWrapper *> *allResourceWrappers = self.wrappers.allValues;
    for (ZHYResourceWrapper *aResourceWrapper in allResourceWrappers) {
        @autoreleasepool {
            NSString *resourceFilename = [[self class] filenameForWrapper:aResourceWrapper];
            NSString *resourcePath = [contentPath stringByAppendingPathComponent:resourceFilename];
            if (![NSKeyedArchiver archiveRootObject:aResourceWrapper toFile:resourcePath]) {
                ZHYLogError(@"'%@' write resource wrapper '%@' at '%@' failure.", self, aResourceWrapper, resourcePath);
                return NO;
            }
        }
    }
    
    return YES;
}

- (instancetype)initWithInfos:(NSDictionary<NSString *, id> *)infos {
    id versionValue = [infos objectForKey:kZHYResourceContainerInfoKeyVersion];
    if (versionValue == nil || ![versionValue isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    NSInteger version = [versionValue integerValue];
    if (version > kZHYResourceContainerInfoValueVersion) {
        [NSException raise:NSInternalInconsistencyException format:@"'Current accept max version is '%zd', your version is '%zd'. Please update.", kZHYResourceContainerInfoValueVersion, version];
        return nil;
    }
    
    id resourceTypeValue = [infos objectForKey:kZHYResourceContainerInfoKeyType];
    if (resourceTypeValue == nil || ![resourceTypeValue isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid resource type '%@' in '%@'.", resourceTypeValue, infos];
        return nil;
    }
    
    self = [super init];
    if (self) {
        _wrappers = [NSMutableDictionary dictionary];
        _resourceType = resourceTypeValue;
    }
    
    return self;
}

+ (instancetype)containerWithContentPath:(NSString *)contentPath {
    if (contentPath == nil) {
        ZHYLogError(@"'%@' can not load from `nil` path.", self, contentPath);
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *infosFilePath = [contentPath stringByAppendingPathComponent:kZHYResourceContainerInfoFileName];
    if (![fileManager fileExistsAtPath:infosFilePath]) {
        ZHYLogError(@"'%@' can not load from '%@' because of nonexistent path.", self, infosFilePath);
        return nil;
    }
    
    NSDictionary<NSString *, id> *infos = [NSDictionary dictionaryWithContentsOfFile:infosFilePath];
    if (infos == nil) {
        ZHYLogError(@"'%@' can not load from '%@'.", self, infosFilePath);
        return nil;
    }
    
    ZHYResourceContainer *container = [[ZHYResourceContainer alloc] initWithInfos:infos];
    if (container) {
        NSError *error = nil;
        NSArray<NSString *> *contents = [fileManager contentsOfDirectoryAtPath:contentPath error:&error];
        if (contents == nil) {
            ZHYLogError(@"'%@' can not get contents at '%@'. <error: %@>", self, contentPath, error);
            return nil;
        }
        
        NSMutableArray<NSString *> *resourceNames = [NSMutableArray arrayWithCapacity:contents.count];
        for (NSString *aContentName in contents) {
            if ([aContentName.pathExtension isEqualToString:kZHYResourceFilePathExtension]) {
                [resourceNames addObject:aContentName];
            }
        }
        
        for (NSString *aResourceName in resourceNames) {
            @autoreleasepool {
                NSString *resourcePath = [contentPath stringByAppendingPathComponent:aResourceName];
                id object = [NSKeyedUnarchiver unarchiveObjectWithFile:resourcePath];
                if (object != nil && [object isKindOfClass:[ZHYResourceWrapper class]]) {
                    [container addResourceWrapper:object];
                } else {
                    ZHYLogError(@"'%@' can not unarchive resource at '%@'.", self, resourcePath);
                }
            }
        }
    }
    
    return container;
}

@end
