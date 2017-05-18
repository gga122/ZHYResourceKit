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
