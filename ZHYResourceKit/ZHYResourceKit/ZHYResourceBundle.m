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
        _bundleName = [bundleName copy];
        _priority = priority;
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

- (NSArray<NSString *> *)allResourceTypes {
    return self.resourceTypes.allObjects;
}

@end

@implementation ZHYResourceBundle (Serializer)

@end
