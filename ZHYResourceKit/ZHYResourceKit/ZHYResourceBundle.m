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

@interface ZHYResourceBundle ()

@property (nonatomic, strong) NSMutableDictionary<ZHYResourceBundleInfoKey, id> *resourceBundleInfo;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceContainer *> *resourceContainers;

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

#pragma mark - Public Methods

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper {
    if (resourceWrapper == nil) {
        ZHYLogError(@"'%@' can not add `nil` resource wrapper. <callstack: %@>", self, [NSThread callStackSymbols]);
        return;
    }
    
    NSString *resourceType = [[resourceWrapper class] resourceType];
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

@end

@implementation ZHYResourceBundle (Serializer)

@end
