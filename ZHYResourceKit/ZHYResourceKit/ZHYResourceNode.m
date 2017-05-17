//
//  ZHYResourceNode.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceNode.h"
#import "ZHYResourceMap.h"

@interface ZHYResourceNode ()

@property (nonatomic, strong) NSMutableArray<ZHYResourceWrapper *> *resources;
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
        
        [self.resources addObject:resourceWrapper];
        [self.resourcesMap setObject:resourceWrapper forKey:resourceWrapper.name];
    }
}

#pragma mark - Public Property

- (NSArray<ZHYResourceWrapper *> *)allResourceWrappers {
    if (self.resources.count == 0) {
        return nil;
    }
    
    NSArray *allResourceWrappers = [NSArray arrayWithArray:self.resources];
    return allResourceWrappers;
}

- (NSArray *)allResources {
    if (self.resources.count == 0) {
        return nil;
    }
    
    NSMutableArray *allResources = [NSMutableArray arrayWithCapacity:self.resources.count];
    for (ZHYResourceWrapper *aWrapper in self.resources) {
        id resource = aWrapper.resource;
        if (!resource) {
            ZHYLogError(@"Resource wrapper did not contain a resource. <wrapper: %@>", aWrapper);
            continue;
        }
        
        [allResources addObject:resource];
    }
    
    return allResources;
}

#pragma mark - Private Property

- (NSMutableArray *)resources {
    if (!_metaInfos) {
        return nil;
    }
    
    if (!_resources) {
        _resources = [NSMutableArray array];
    }
    
    return _resources;
}

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
