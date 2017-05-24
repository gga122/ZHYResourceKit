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

@property (nonatomic, copy) id<ZHYResourceInfo> resourceInfo;

@end

@implementation ZHYResourceWrapper

#pragma mark - DESIGNATED INITIALIZER

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
        _resourceInfo = [info copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[ZHYResourceWrapper class]]) {
        return [self isEqualToZHYResourceWrapper:object];
    }
    
    return NO;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYResourceWrapper *wrapper = [[ZHYResourceWrapper allocWithZone:zone] initWithResourceInfo:self.resourceInfo];
    return wrapper;
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYResourceWrapper:(ZHYResourceWrapper *)wrapper {
    if (![self.name isEqualToString:wrapper.name]) {
        return NO;
    }
    
    if (![self.resourceInfo isEqual:wrapper]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Public Property

- (NSString *)name {
    return self.resourceInfo.name;
}

- (id)resource {    
    if (![self class].transformer || !self.resourceInfo.content) {
        return nil;
    }
    
    id r = [[self class].transformer transformedValue:self.resourceInfo.content];
    if (!r) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid resource. <resourceInfo: %@>", _resourceInfo];
    }
    
    return r;
}

- (NSString *)detail {
    return self.resourceInfo.detail;
}

+ (NSValueTransformer *)transformer {
    return nil;
}

#pragma mark - Private Property

- (id<ZHYResourceInfo>)resourceInfo {
    return [_resourceInfo copy];
}

@end
