//
//  ZHYResourceWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"
#import "ZHYLogger.h"
#import "ZHYResourceKitDefines.h"

static NSString * const kZHYResourceWrapperKeyCodingDescriptor = @"descriptor";

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

- (instancetype)initWithResourceDescriptor:(id<ZHYResourceDescriptor>)descriptor {
    if (!isValidResourceDescriptor(descriptor)) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceDescriptor = descriptor;
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

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resourceDescriptor forKey:kZHYResourceWrapperKeyCodingDescriptor];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    id<ZHYResourceDescriptor> descriptor = [aDecoder decodeObjectForKey:kZHYResourceWrapperKeyCodingDescriptor];
    return [self initWithResourceDescriptor:descriptor];
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYResourceWrapper:(ZHYResourceWrapper *)wrapper {
    if (![self.resourceName isEqualToString:wrapper.resourceName]) {
        return NO;
    }
    
    if (![self.resourceDescriptor isEqual:wrapper.resourceDescriptor]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Public Property

- (NSString *)resourceName {
    return self.resourceDescriptor.resourceName;
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

- (NSString *)resourceDetail {
    return self.resourceDescriptor.resourceDetail;
}

- (NSString *)resourceType {
    return [[self.resourceDescriptor class] resourceType];
}

+ (NSValueTransformer *)transformer {
    return nil;
}

@end
