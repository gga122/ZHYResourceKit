//
//  ZHYResourceWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceWrapper.h"

@interface ZHYResourceWrapper ()

@property (nonatomic, strong) id<ZHYResourceInfo> resourceInfo;

@property (nonatomic, readwrite) id resource;
@property (nonatomic, assign) BOOL didTransform;

@end

@implementation ZHYResourceWrapper

- (instancetype)initWithResourceInfo:(id<ZHYResourceInfo>)info {
    if (!info) {
        ZHYLogError(@"Resource info is nil");
        return nil;
    }
    
    if (!info.name) {
        ZHYLogError(@"Resource name is nil. <Resource: %@>", info);
        return nil;
    }
    
    if (!info.content) {
        ZHYLogError(@"Resource content is nil. <Resource: %@>", info);
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceInfo = info;
    }
    
    return self;
}

#pragma mark - Public Property

- (NSString *)name {
    return self.resourceInfo.name;
}

- (id)resource {
    if (self.didTransform) {
        return _resource;
    }
    self.didTransform = YES;
    
    if (!self.transformer || !self.resourceInfo.content) {
        return nil;
    }
    
    _resource = [self.transformer transformedValue:self.resourceInfo.content];
    return _resource;
}

- (NSString *)detail {
    return self.resourceInfo.detail;
}

@end
