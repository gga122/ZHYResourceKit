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

@interface ZHYFontInfo ()

@property (nonatomic, copy, readonly) NSDictionary *fontDescriptor;

@end

@implementation ZHYFontInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithDescriptor:(NSDictionary *)descriptor forName:(NSString *)name {
    BOOL isGuard = (!descriptor || !name);
    if (isGuard) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _name = [name copy];
        _descriptor = [descriptor copy];
    }
    
    return self;
}

- (instancetype)initWithFont:(NSFont *)font resourceName:(NSString *)resourceName {
    if (font == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _name = [resourceName copy];
        
        CGFloat fontSize = font.pointSize;
        NSDictionary *fontAttributes = font.fontDescriptor.fontAttributes;
        
        _descriptor = @{kZHYFontInfoDescriptorKeySize: @(fontSize), kZHYFontInfoDescriptorKeyAttributes: fontAttributes};
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _name];
    [desc appendFormat:@"<font: %@>", _descriptor];
    if (_detail) {
        [desc appendFormat:@"<detail: %@>", _detail];
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
    if (![self.name isEqualToString:fontInfo.name]) {
        return NO;
    }
    
    if (![self.descriptor isEqualToDictionary:fontInfo.descriptor]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYFontInfo *info = [[ZHYFontInfo allocWithZone:zone] initWithDescriptor:self.descriptor forName:self.name];
    info.detail = self.detail;
    
    return info;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:kZHYFontInfoKeyCodingName];
    [aCoder encodeObject:self.descriptor forKey:kZHYFontInfoKeyCodingFontDescriptor];
    [aCoder encodeObject:self.detail forKey:kZHYFontInfoKeyCodingDetail];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingName];
    NSDictionary *descriptor = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingFontDescriptor];
    NSString *detail = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingDetail];
    
    self = [super init];
    if (self) {
        _name = name;
        _descriptor = descriptor;
        _detail = detail;
    }
    
    return self;
}

#pragma mark - ZHYResourceInfo Protocol

- (id)content {
    return self.descriptor;
}

- (void)setContent:(id)content {
    if (![content isKindOfClass:[NSDictionary class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid content type. <content: %@>", content];
    } else {
        self.descriptor = content;
    }
}

+ (NSString *)resourceType {
    return kZHYResourceKeyTypeFont;
}

@end
