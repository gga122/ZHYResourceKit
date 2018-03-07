//
//  ZHYResourceBundle.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceBundle.h"
#import "ZHYResourceBundleDefines.h"
#import "ZHYLogger.h"

struct ZHYResourceBundleFlags {
    
};

@interface ZHYResourceBundle ()

@property (nonatomic, strong) NSMutableDictionary<ZHYResourceBundleInfoKey, id> *resourceBundleInfo;
@property (nonatomic, strong) NSMutableSet<NSString *> *resourceTypes;

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
    }
    
    return self;
}

#pragma mark - Public Methods

- (void)addResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        return;
    }
    
    [self.resourceTypes addObject:resourceType];
}

- (void)removeResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        return;
    }
    
    [self.resourceTypes removeObject:resourceType];
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
    return self.resourceTypes.allObjects;
}

@end

@implementation ZHYResourceBundle (Serializer)

@end
