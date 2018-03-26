//
//  ZHYFontWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYFontWrapper.h"
#import "ZHYResourceKitDefines.h"

@implementation ZHYFontWrapper

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYFontWrapper class]) {
        [ZHYFontTransformer class]; // make transformer class awake
    }
}

#pragma mark - Public Property

- (ZHYFont *)font {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYFontTransformer];
}

@end

NSString * const kZHYFontInfoDescriptorKeySize = @"fontSize";
NSString * const kZHYFontInfoDescriptorKeyAttributes = @"fontAttributes";

static NSString * const kZHYFontInfoKeyCodingName = @"fontName";
static NSString * const kZHYFontInfoKeyCodingFontDescriptor = @"fontDescriptor";
static NSString * const kZHYFontInfoKeyCodingDetail = @"fontDetail";

NS_INLINE NSDictionary *safeCopyFontInfoDescriptor(NSDictionary<NSString *, id> *fontInfoDescriptor) {
    NSDictionary *safeFontAttributes = [[fontInfoDescriptor objectForKey:kZHYFontInfoDescriptorKeyAttributes] copy];
    NSNumber *safeFontSize = [fontInfoDescriptor objectForKey:kZHYFontInfoDescriptorKeySize];
    
    return @{kZHYFontInfoDescriptorKeySize: safeFontSize,
             kZHYFontInfoDescriptorKeyAttributes: safeFontAttributes};
}

@interface ZHYFontInfo ()

- (instancetype)initWithFontInfoDescriptor:(NSDictionary *)descriptor resourceName:(NSString *)resourceName NS_DESIGNATED_INITIALIZER;

@end

@implementation ZHYFontInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithFont:(NSFont *)font resourceName:(NSString *)resourceName {
    if (font == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceName = [resourceName copy];
        
        CGFloat fontSize = font.pointSize;
        NSDictionary *fontAttributes = font.fontDescriptor.fontAttributes;
        
        _descriptor = @{kZHYFontInfoDescriptorKeySize: @(fontSize), kZHYFontInfoDescriptorKeyAttributes: fontAttributes};
    }
    
    return self;
}

- (instancetype)initWithFontInfoDescriptor:(NSDictionary *)descriptor resourceName:(NSString *)resourceName {
    if (resourceName == nil) {
        return nil;
    }
    if (!isValidFontInfoDescriptor(descriptor)) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _descriptor = safeCopyFontInfoDescriptor(descriptor);
        _resourceName = [resourceName copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _resourceName];
    [desc appendFormat:@"<font: %@>", _descriptor];
    if (_resourceDetail) {
        [desc appendFormat:@"<detail: %@>", _resourceDetail];
    }
    
    return desc;
}

- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[ZHYFontInfo class]]) {
        return [self isEqualToZHYFontInfo:object];
    }
    
    return NO;
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYFontInfo:(ZHYFontInfo *)fontInfo {
    if (![self.resourceName isEqualToString:fontInfo.resourceName]) {
        return NO;
    }
    
    if (![self.descriptor isEqualToDictionary:fontInfo.descriptor]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYFontInfo *info = [[ZHYFontInfo allocWithZone:zone] initWithFontInfoDescriptor:_descriptor resourceName:_resourceName];
    info->_resourceDetail = [_resourceDetail copy];
    
    return info;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.resourceName forKey:kZHYFontInfoKeyCodingName];
    [aCoder encodeObject:self.descriptor forKey:kZHYFontInfoKeyCodingFontDescriptor];
    [aCoder encodeObject:self.resourceDetail forKey:kZHYFontInfoKeyCodingDetail];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingName];
    NSDictionary *descriptor = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingFontDescriptor];
    NSString *detail = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingDetail];
    
    self = [super init];
    if (self) {
        _resourceName = name;
        _descriptor = descriptor;
        _resourceDetail = detail;
    }
    
    return self;
}

#pragma mark - ZHYResourceDescriptor

- (id<NSCoding>)resourceContents {
    return self.descriptor;
}

- (void)setResourceContents:(id<NSCoding>)resourceContents {
    
}

+ (NSString *)resourceType {
    return kZHYResourceKeyTypeFont;
}

@end

FOUNDATION_EXTERN BOOL isValidFontInfoDescriptor(NSDictionary<NSString *, id> *fontInfoDescriptor) {
    if (fontInfoDescriptor == nil) {
        return NO;
    }
    
    if ([fontInfoDescriptor objectForKey:kZHYFontInfoDescriptorKeySize] == nil) {
        return NO;
    }
    if ([fontInfoDescriptor objectForKey:kZHYFontInfoDescriptorKeyAttributes] == nil) {
        return NO;
    }
    
    return YES;
}
