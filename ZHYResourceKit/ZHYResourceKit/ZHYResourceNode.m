//
//  ZHYResourceNode.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceNode+Private.h"
#import "ZHYResourceMap.h"

@interface ZHYResourceNode ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceWrapper *> *resourcesMap;

@property (nonatomic, assign) Class wrapperClass;
@property (nonatomic, assign) Class<ZHYResourceInfo> infoClass;

@property (nonatomic, strong) NSCache *cachedResources;
@property (nonatomic, assign) BOOL didAwake;

@end

@implementation ZHYResourceNode

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithClassification:(NSString *)classification metaInfos:(nonnull NSArray<NSDictionary *> *)metaInfos {
    if (!classification || !metaInfos) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _classification = [classification copy];
        _metaInfos = [metaInfos copy];
        
        _wrapperClass = [ZHYResourceMap wrapperForClassification:_classification];
        _infoClass = [ZHYResourceMap infoForClassification:_classification];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<Classification: %@>", _classification];
    [desc appendFormat:@"<Wrapper: %@>", _wrapperClass];
    [desc appendFormat:@"<Info: %@>", _infoClass];
    
    return desc;
}

#pragma mark - Public Methods

- (id)resourceForName:(NSString *)name {
    if (!name) {
        return nil;
    }
    
    if (!self.didAwake) {   // lazy load resource infos
        [self loadResources];
        self.didAwake = YES;
    }
    
    id resource = [self.cachedResources objectForKey:name];
    if (!resource) {
        ZHYResourceWrapper *resourceWrapper = [self.resourcesMap objectForKey:name];
        resource = resourceWrapper.resource;
        
        if (resource) {
            [self.cachedResources setObject:resource forKey:name];
        }
    }
    
    return resource;
}

#pragma mark - Private Methods

- (void)loadResources {
    Class wrapperClass = self.wrapperClass;
    Class<ZHYResourceInfo> infoClass = self.infoClass;
    NSArray *metaInfos = self.metaInfos;
    
    BOOL isGuard = (!wrapperClass || !infoClass || metaInfos.count == 0);
    if (isGuard) {
        return;
    }
    
    for (NSDictionary *aInfo in metaInfos) {
        @autoreleasepool {
            id<ZHYResourceInfo> aResourceInfo = [infoClass decodeFromPlist:aInfo];
            if (!aResourceInfo) {
                ZHYLogWarning(@"Create resource info failed. <plist: %@>", aInfo);
                continue;
            }
            
            ZHYResourceWrapper *resourceWrapper = [[wrapperClass alloc] initWithResourceInfo:aResourceInfo];
            if (!resourceWrapper) {
                ZHYLogWarning(@"Create resource wrapper failed. <resource info: %@>", aResourceInfo);
                continue;
            }
            
            if ([self.resourcesMap objectForKey:resourceWrapper.name]) {
                ZHYLogError(@"Found duplicate resource. <name: %@>", resourceWrapper.name);
                continue;
            }
            
            [self.resourcesMap setObject:resourceWrapper forKey:resourceWrapper.name];
        }
    }
}

#pragma mark - Private Methods

- (BOOL)addResourceInfo:(id<ZHYResourceInfo>)resourceInfo {
    if ([self.resourcesMap objectForKey:resourceInfo.name]) {
        return NO;
    }
    
    ZHYResourceWrapper *resourceWrapper = [[self.wrapperClass alloc] initWithResourceInfo:resourceInfo];
    [self.resourcesMap setObject:resourceWrapper forKey:resourceWrapper.name];
    
    return YES;
}

- (BOOL)removeResourceInfo:(id<ZHYResourceInfo>)resourceInfo {
    if (![self.resourcesMap objectForKey:resourceInfo.name]) {
        return NO;
    }
    
    ZHYResourceWrapper *resourceWrapper = [[self.wrapperClass alloc] initWithResourceInfo:resourceInfo];
    [self.resourcesMap removeObjectForKey:resourceWrapper.name];
    
    return YES;
}

- (NSArray<NSDictionary<NSString *, id> *> *)archiveToPlist {
    NSArray<ZHYResourceWrapper *> *allResourceWrappers = self.allResourceWrappers;
    
    NSMutableArray *plist = [NSMutableArray arrayWithCapacity:allResourceWrappers.count];
    
    for (ZHYResourceWrapper *aWrapper in allResourceWrappers) {
        @autoreleasepool {
            id<ZHYResourceInfo> resourceInfo = aWrapper.resourceInfo;
            NSDictionary *infoPlist = [resourceInfo encodeToPlist];
            
            if (!infoPlist) {
                continue;
            }
            
            [plist addObject:infoPlist];
        }
    }
    
    return plist;
}

#pragma mark - Public Property

- (NSArray<ZHYResourceWrapper *> *)allResourceWrappers {
    if (!self.didAwake) {   // lazy load resource infos
        [self loadResources];
        self.didAwake = YES;
    }
    
    return self.resourcesMap.allValues;
}

- (NSArray *)allResources {
    NSArray<ZHYResourceWrapper *> *allResourceWrappers = self.allResourceWrappers;
    if (allResourceWrappers.count == 0) {
        return nil;
    }
    
    NSMutableArray *allResources = [NSMutableArray arrayWithCapacity:allResourceWrappers.count];
    for (ZHYResourceWrapper *aWrapper in allResourceWrappers) {
        @autoreleasepool {
            id resource = aWrapper.resource;
            if (!resource) {
                ZHYLogError(@"Resource wrapper did not contain a resource. <wrapper: %@>", aWrapper);
                continue;
            }
            
            [allResources addObject:resource];
        }
    }
    
    return allResources;
}

#pragma mark - Private Property

- (NSMutableDictionary *)resourcesMap {
    if (!_metaInfos) {
        return nil;
    }
    
    if (!_resourcesMap) {
        _resourcesMap = [NSMutableDictionary dictionary];
    }
    
    return _resourcesMap;
}

- (NSCache *)cachedResources {
    if (!_cachedResources) {
        _cachedResources = [[NSCache alloc] init];
    }
    
    return _cachedResources;
}

@end
