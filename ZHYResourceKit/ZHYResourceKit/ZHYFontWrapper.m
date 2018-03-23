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

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithFont:(NSFont *)font name:(NSString *)name {
    
}

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

static NSString * const kZHYFontInfoKeyCodingName = @"fontName";
static NSString * const kZHYFontInfoKeyCodingFontDescriptor = @"fontDescriptor";
static NSString * const kZHYFontInfoKeyCodingFontSize = @"fontSize";
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
    
    CGFloat fontSize = self.font.pointSize;
    [aCoder encodeDouble:fontSize forKey:kZHYFontInfoKeyCodingFontSize];
    
    NSDictionary *fontAttributes = self.font.fontDescriptor.fontAttributes;
    [aCoder encodeObject:fontAttributes forKey:kZHYFontInfoKeyCodingFontDescriptor];
    
    [aCoder encodeObject:self.detail forKey:kZHYFontInfoKeyCodingDetail];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSString *name = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingName];
    
    CGFloat fontSize = [aDecoder decodeDoubleForKey:kZHYFontInfoKeyCodingFontSize];
    NSDictionary *fontAttributes = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingFontDescriptor];
    NSFontDescriptor *fontDescriptor = [NSFontDescriptor fontDescriptorWithFontAttributes:fontAttributes];
    NSFont *font = [NSFont fontWithDescriptor:fontDescriptor size:fontSize];
    
    NSString *detail = [aDecoder decodeObjectForKey:kZHYFontInfoKeyCodingDetail];
    
    self = [self initWithFont:font resourceName:name];
    if (self) {
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

- (NSDictionary *)encodeToPlist {
    if (!self.name || !self.descriptor) {
        return nil;
    }
    
    NSMutableDictionary<NSString *, id> *plist = [NSMutableDictionary dictionary];
    
    [plist setObject:self.name forKey:kZHYFontKeyName];
    [plist setObject:self.descriptor forKey:kZHYFontKeyFont];
    if (self.detail) {
        [plist setObject:self.detail forKey:kZHYFontKeyDetail];
    }
    
    return plist;
}

+ (instancetype)decodeFromPlist:(NSDictionary *)plist {
    NSString *name = [plist objectForKey:kZHYFontKeyName];
    if (!name) {
        return nil;
    }
    
    NSDictionary *descriptor = [plist objectForKey:kZHYFontKeyFont];
    if (!descriptor) {
        return nil;
    }
    
    ZHYFontInfo *info = [[ZHYFontInfo alloc] initWithDescriptor:descriptor forName:name];
    NSString *detail = [plist objectForKey:kZHYColorKeyDetail];
    info.detail = detail;
    
    return info;
}

@end
