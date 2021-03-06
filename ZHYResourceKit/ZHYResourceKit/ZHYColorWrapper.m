//
//  ZHYColorWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYColorWrapper.h"
#import "ZHYResourceKitDefines.h"

@implementation ZHYColorWrapper

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYColorWrapper self]) {
        [ZHYColorTransformer class];
    }
}

#pragma mark - Public Property

- (ZHYColor *)color {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYColorTransformer];
}

@end

static NSString * const kZHYColorInfoKeyCodingName = @"colorName";
static NSString * const kZHYColorInfoKeyCodingRepresentation = @"colorRepresentation";
static NSString * const kZHYColorInfoKeyCodingDetail = @"colorDetail";

@interface ZHYColorInfo ()

- (instancetype)initWithColorRepresentation:(NSString *)colorRepresentation resourceName:(NSString *)resourceName NS_DESIGNATED_INITIALIZER;

@end

@implementation ZHYColorInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithColor:(ZHYColor *)color resourceName:(NSString *)resourceName {
    if (color == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceName = [resourceName copy];
        
        CIColor *c = nil;
#if TARGET_OS_IOS
        c = [[CIColor alloc] initWithColor:color];
#else
        c = [[CIColor alloc] initWithColor:color];
#endif
        _representation = c.stringRepresentation;
    }
    
    return self;
}

- (instancetype)initWithColorRepresentation:(NSString *)colorRepresentation resourceName:(NSString *)resourceName {
    if (colorRepresentation == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _representation = [colorRepresentation copy];
        _resourceName = [resourceName copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _resourceName];
    [desc appendFormat:@"<hex: %@>", _representation];
    if (_resourceDetail) {
        [desc appendFormat:@"<detail: %@>", _resourceDetail];
    }
    
    return desc;
}

- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[ZHYColorInfo class]]) {
        return [self isEqualToZHYColorInfo:object];
    }
    
    return NO;
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYColorInfo:(ZHYColorInfo *)colorInfo {
    if (![self.resourceName isEqualToString:colorInfo.resourceName]) {
        return NO;
    }
    
    if (![self.representation isEqualToString:colorInfo.representation]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYColorInfo *info = [[ZHYColorInfo allocWithZone:zone] initWithColorRepresentation:_representation resourceName:_resourceName];
    info->_resourceDetail = [_resourceDetail copy];
    
    return info;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resourceName forKey:kZHYColorInfoKeyCodingName];
    [aCoder encodeObject:self.representation forKey:kZHYColorInfoKeyCodingRepresentation];
    [aCoder encodeObject:self.resourceDetail forKey:kZHYColorInfoKeyCodingDetail];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *resourceName = [aDecoder decodeObjectForKey:kZHYColorInfoKeyCodingName];
    NSString *representation = [aDecoder decodeObjectForKey:kZHYColorInfoKeyCodingRepresentation];
    NSString *resourceDetail = [aDecoder decodeObjectForKey:kZHYColorInfoKeyCodingDetail];
    
    self = [super init];
    if (self) {
        _resourceName = resourceName;
        _representation = representation;
        _resourceDetail = resourceDetail;
    }
    
    return self;
}

#pragma mark - ZHYResourceDescriptor

- (id<NSCoding>)resourceContents {
    return self.representation;
}

- (void)setResourceContents:(id<NSCoding>)resourceContents {
    
}

+ (NSString *)resourceType {
    return kZHYResourceKeyTypeColor;
}

@end
