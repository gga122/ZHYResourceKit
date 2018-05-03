//
//  ZHYResourceBundle.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceBundle.h"
#import "ZHYResourceContainer.h"
#import "ZHYResourceWrapper.h"
#import "ZHYResourceBundleDefines.h"
#import "ZHYLogger.h"

/*****
 Construction of `ZHYResourceBundle`
 
 'Class Construction'                        'File Construction'
 
 |- `ZHYResourceBundle`                      |---- `..\*.bundle`
 |---- `resourceBundleInfo`                  |---- `..\*.bundle\ZHYResourceBundleInfo.plist`
 |---- `resourceContainers`                  |---- `..\*.bundle\ZHYResources\`
 |-------- `ZHYResourceContainer`            |-------- `..\*.bundle\ZHYResources\${resourceType}\`
  
 *****/

@interface ZHYResourceBundle () <ZHYResourceContainerDataSource, ZHYResourceContainerDelegate>

@property (nonatomic, strong) NSMutableDictionary<ZHYResourceBundleInfoKey, id> *resourceBundleInfo;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceContainer *> *resourceContainers;

@property (nonatomic, copy) NSString *path;

- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

@end

@implementation ZHYResourceBundle

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundleName:(NSString *)bundleName priority:(NSUInteger)priority {
    if (bundleName == nil) {
        ZHYLogError(@"Bundle name can not be nil.");
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceBundleInfo = createResourceBundleTempleteInfo();
        
        [_resourceBundleInfo setObject:[bundleName copy] forKey:kZHYResourceBundleName];
        [_resourceBundleInfo setObject:@(priority) forKey:kZHYResourceBundlePriority];
        
        _resourceContainers = [NSMutableDictionary dictionary];
    }
    
    return self;
}

/* Private designated initializer */
- (instancetype)initWithPath:(NSString *)path {
    if (path == nil) {
        ZHYLogError(@"'%@' can not init with nil path.", [self class]);
        return nil;
    }
    
    NSString *resourceBundleInfoPath = [path stringByAppendingPathComponent:kZHYResourceBundleInfoFileName];
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithContentsOfFile:resourceBundleInfoPath];
    NSError *error = nil;
    if (!isValidResourceBundleInfo(info, &error)) {
        ZHYLogError(@"'%@' can not init because of invalid resource bundle info '%@' at '%@'. <error: %@>", [self class], info, resourceBundleInfoPath, error);
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceContainers = [NSMutableDictionary dictionary];
        _resourceBundleInfo = info;
        _path = [path copy];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *resourceDirectory = [path stringByAppendingPathComponent:kZHYResourceBundleResourceDirectoryName];
        NSError *error = nil;
        NSArray<NSString *> *contents = [fileManager contentsOfDirectoryAtPath:resourceDirectory error:&error];
        if (contents == nil) {
            ZHYLogError(@"Can not find contents of directory at '%@'. <error: %@>", resourceDirectory, error);
        } else {
            NSMutableArray<NSString *> *directoryNames = [NSMutableArray arrayWithCapacity:contents.count];
            
            for (NSString *aContentName in contents) {
                @autoreleasepool {
                    NSString *contentPath = [resourceDirectory stringByAppendingPathComponent:aContentName];
                    BOOL isDirectory = NO;
                    if ([fileManager fileExistsAtPath:contentPath isDirectory:&isDirectory] && isDirectory) {
                        [directoryNames addObject:aContentName];
                    }
                }
            }
            
            for (NSString *aDirectoryName in directoryNames) {
                ZHYResourceContainer *container = [ZHYResourceContainer containerWithContentPath:aDirectoryName];
                if (container == nil) {
                    continue;
                }
                container.delegate = self;
                [_resourceContainers setObject:container forKey:container.resourceType];
            }
        }
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    if (resourceWrapper == nil) {
        ZHYLogError(@"'%@' can not add `nil` resource wrapper. <callstack: %@>", self, [NSThread callStackSymbols]);
        return;
    }
    
    NSString *resourceType = resourceWrapper.resourceType;
    ZHYResourceContainer *container = [self containerForResourceType:resourceType];
    if (container == nil) {
        container = [[ZHYResourceContainer alloc] initWithResourceType:resourceType];
        container.delegate = self;
        [self.resourceContainers setObject:container forKey:resourceType];
    }
    
    [container addResourceWrapper:resourceWrapper];
}

- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    if (resourceWrapper == nil) {
        ZHYLogError(@"'%@' can not remove `nil` resource wrapper. <callstack: %@>", self, [NSThread callStackSymbols]);
        return;
    }
    
    NSString *resourceType = [[resourceWrapper class] resourceType];
    ZHYResourceContainer *container = [self containerForResourceType:resourceType];
    if (container == nil) {
        ZHYLogError(@"'%@' can not found resource wrapper '%@'. <callstack: %@>", self, resourceWrapper, [NSThread callStackSymbols]);
        return;
    }
    
    [container removeResourceWrapper:resourceWrapper];
}

- (NSArray<ZHYResourceWrapper *> *)resourceWrappersForResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        ZHYLogError(@"'%@' can not found resource wrappers for `nil`. <callstack: %@>", self, [NSThread callStackSymbols]);
        return nil;
    }
    
    ZHYResourceContainer *container = [self containerForResourceType:resourceType];
    return container.allResourceWrappers;
}

#pragma mark - ZHYResourceContainerDataSource

- (NSString *)contentPathOfContainer:(ZHYResourceContainer *)container {
    return [self contentPathOfContainer:container bundlePath:self.path];
}

#pragma mark - ZHYResourceContainerDelegate

- (void)resourceContainer:(ZHYResourceContainer *)container didAddWrapper:(ZHYResourceWrapper *)resourceWrapper conflictedWrapper:(ZHYResourceWrapper *)wrapper {
    // TODO: Notification
}

- (void)resourceContainer:(ZHYResourceContainer *)container didRemoveWrapper:(ZHYResourceWrapper *)resourceWrapper {
    // TODO: Notification
}

#pragma mark - Private Methods

- (NSString *)contentPathOfContainer:(ZHYResourceContainer *)container bundlePath:(NSString *)bundlePath {
    if (container == nil) {
        ZHYLogWarning(@"'%@' do not have content path of `nil`.", self);
        return nil;
    }
    
    if (bundlePath == nil) {
        ZHYLogWarning(@"'%@' do not create bundle on disk.", self);
        return nil;
    }
    
    NSString *path = [bundlePath stringByAppendingPathComponent:kZHYResourceBundleResourceDirectoryName];
    path = [path stringByAppendingPathComponent:container.resourceType];
    
    return path;
}

- (ZHYResourceContainer *)containerForResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        ZHYLogWarning(@"'%@' can not found container for `nil` type.". self);
        return nil;
    }
    
    return [self.resourceContainers objectForKey:resourceType];
}

#pragma mark - Public Property

- (NSString *)bundleName {
    return [self.resourceBundleInfo objectForKey:kZHYResourceBundleName];
}

- (NSUInteger)priority {
    NSNumber *priority = [self.resourceBundleInfo objectForKey:kZHYResourceBundlePriority];
    return [priority unsignedIntegerValue];
}

- (NSArray<NSString *> *)allResourceTypes {
    return self.resourceContainers.allKeys;
}

- (NSDictionary<NSString *,id> *)bundleInfos {
    return [NSDictionary dictionaryWithDictionary:self.resourceBundleInfo];
}

@end

@implementation ZHYResourceBundle (Serializer)

#pragma mark - Public Methods

- (BOOL)writeToContentPath:(NSString *)contentPath {
    if (self.path != nil && ![self.path isEqualToString:contentPath]) {
        ZHYLogError(@"'%@' can not write to '%@' because of different path. <path: %@>", self, contentPath, self.path);
        return NO;
    }
    
    NSString *lastComponent = contentPath.lastPathComponent;
    if (![lastComponent.pathExtension isEqualToString:@"bundle"]) {
        ZHYLogError(@"'%@' can not write to '%@' because of invalid last component.", self, contentPath);
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:contentPath]) {
        ZHYLogError(@"'%@' can not write to '%@' because of existed.", self, contentPath);
        return NO;
    }
    
    NSError *error = nil;
    if (![fileManager createDirectoryAtPath:contentPath withIntermediateDirectories:YES attributes:nil error:&error]) {
        ZHYLogError(@"'%@' create directory at '%@' failure. <error: %@>", self, contentPath, error);
        return NO;
    }
    
    /* write bundle infos */
    NSString *infoFilePath = [contentPath stringByAppendingPathComponent:kZHYResourceBundleInfoFileName];
    BOOL didWrite = [self.resourceBundleInfo writeToFile:infoFilePath atomically:YES];
    if (!didWrite) {
        ZHYLogError(@"'%@' write resource bundle info at '%@' failure.", self, infoFilePath);
        return NO;
    }
    
    /* write containers contents */
    NSArray<ZHYResourceContainer *> *allContainers = self.resourceContainers.allValues;
    for (ZHYResourceContainer *aContainer in allContainers) {
        NSString *containerPath = [self contentPathOfContainer:aContainer bundlePath:contentPath];
        [aContainer writeToContentPath:containerPath];
    }
    
    self.path = contentPath;
    return YES;
}

+ (instancetype)containerWithContentPath:(NSString *)contentPath {
    ZHYResourceBundle *resourceBundle = [[ZHYResourceBundle alloc] initWithPath:contentPath];
    return resourceBundle;
}

+ (instancetype)resourceBundleWithBundle:(NSBundle *)bundle {
    return [self containerWithContentPath:bundle.bundlePath];
}

#pragma mark - Private Methods


@end
