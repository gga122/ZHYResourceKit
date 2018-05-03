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
        _resourceType = [resourceType copy];
        _wrappers = [NSMutableDictionary dictionary];
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
    
    if ([delegate respondsToSelector:@selector(resourceContainer:didRemoveWrapper:)]) {
        [delegate resourceContainer:self didRemoveWrapper:conflictedWrapper];
    }
}

#pragma mark - Private Methods

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
            NSString *resourcePath = [contentPath stringByAppendingPathComponent:aResourceWrapper.resourceName];
            resourcePath = [resourcePath stringByAppendingPathExtension:kZHYResourceFilePathExtension];
            if (![NSKeyedArchiver archiveRootObject:aResourceWrapper toFile:resourcePath]) {
                ZHYLogError(@"'%@' write resource wrapper '%@' at '%@' failure.", self, aResourceWrapper, resourcePath);
                return NO;
            }
        }
    }
    
    return YES;
}

@end
