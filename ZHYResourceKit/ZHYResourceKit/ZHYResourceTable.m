//
//  ZHYResourceTable.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 23/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceTable.h"

@interface ZHYResourceTable ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceWrapper *> *resourceWrappers;

@end

@implementation ZHYResourceTable

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithResourceType:(NSString *)resourceType {
    if (resourceType == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceWrappers = [NSMutableDictionary dictionary];
        _resourceType = [resourceType copy];
    }
    
    return self;
}

#pragma mark - Public Methods

- (ZHYResourceWrapper *)resourceWrapperForKey:(NSString *)key {
    return [self.resourceWrappers objectForKey:key];
}

- (void)setResourceWrapper:(ZHYResourceWrapper *)wrapper forKey:(NSString *)key {
    [self.resourceWrappers setObject:wrapper forKey:key];
}

- (void)removeResourceWrapperForKey:(NSString *)key {
    [self.resourceWrappers removeObjectForKey:key];
}


#pragma mark - Public Property

- (NSArray<ZHYResourceWrapper *> *)allResourceWrappers {
    return self.resourceWrappers.allValues;
}

@end
