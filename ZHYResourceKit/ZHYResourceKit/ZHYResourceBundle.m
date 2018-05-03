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

@interface ZHYResourceBundle () <ZHYResourceContainerDelegate>

@property (nonatomic, strong) NSMutableDictionary<ZHYResourceBundleInfoKey, id> *resourceBundleInfo;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceContainer *> *resourceContainers;

- (instancetype)initWithBundle:(NSBundle *)bundle NS_DESIGNATED_INITIALIZER;

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
- (instancetype)initWithBundle:(NSBundle *)bundle {
    if (bundle == nil) {
        ZHYLogError(@"'%@' can not init with nil bundle.", [self class]);
        return nil;
    }
    
    NSString *resourceBundleInfoPath = [bundle.bundlePath stringByAppendingPathComponent:kZHYResourceBundleInfoFileName];
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
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *resourceDirectory = [bundle.bundlePath stringByAppendingPathComponent:kZHYResourceBundleResourceDirectoryName];
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
                // TODO: Load from file path
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

#pragma mark - Private Methods

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

- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)atomically {
    NSString *lastComponent = filePath.lastPathComponent;
    if (![lastComponent.pathExtension isEqualToString:@"bundle"]) {
        ZHYLogError(@"'%@' can not write to '%@' because of invalid last component.", self, filePath);
        return NO;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        ZHYLogError(@"'%@' can not write to '%@' because of existed.", self, filePath);
        return NO;
    }
    
    NSError *error = nil;
    if (![fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error]) {
        ZHYLogError(@"'%@' create directory at '%@' failure. <error: %@>", self, filePath, error);
        return NO;
    }

    /* write bundle infos */
    NSString *infoFilePath = [filePath stringByAppendingPathComponent:kZHYResourceBundleInfoFileName];
    BOOL didWrite = [self.resourceBundleInfo writeToFile:infoFilePath atomically:YES];
    if (!didWrite) {
        ZHYLogError(@"'%@' write resource bundle info at '%@' failure.", self, infoFilePath);
        return NO;
    }
    
    /* write containers contents */
    NSString *resourceDirectoryPath = [filePath stringByAppendingPathComponent:kZHYResourceBundleResourceDirectoryName];
    NSArray<NSString *> *allKeys = self.resourceContainers.allKeys;
    for (NSString *aKey in allKeys) {
        @autoreleasepool {
            NSString *subPath = [resourceDirectoryPath stringByAppendingPathComponent:aKey];
            if (![fileManager fileExistsAtPath:subPath]) {
                if (![fileManager createDirectoryAtPath:subPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                    ZHYLogError(@"'%@' create directory for '%@' at '%@' failure. <error: %@>", self, aKey, subPath, error);
                    return NO;
                }
            }
            
            ZHYResourceContainer *container = [self.resourceContainers objectForKey:aKey];
            NSArray<ZHYResourceWrapper *> *allResourceWrappers = container.allResourceWrappers;
            for (ZHYResourceWrapper *aResourceWrapper in allResourceWrappers) {
                @autoreleasepool {
                    NSString *resourcePath = [subPath stringByAppendingPathComponent:aResourceWrapper.resourceName];
                    resourcePath = [resourcePath stringByAppendingPathExtension:kZHYResourceFilePathExtension];
                    if (![NSKeyedArchiver archiveRootObject:aResourceWrapper toFile:resourcePath]) {
                        ZHYLogError(@"'%@' write resource wrapper '%@' at '%@' failure.", self, aResourceWrapper, resourcePath);
                        return NO;
                    }
                }
            }
        }
    }
        
    return YES;
}

+ (instancetype)resourceBundleWithBundle:(NSBundle *)bundle {
    ZHYResourceBundle *resourceBundle = [[ZHYResourceBundle alloc] initWithBundle:bundle];
    return resourceBundle;
}

#pragma mark - Private Methods


@end
