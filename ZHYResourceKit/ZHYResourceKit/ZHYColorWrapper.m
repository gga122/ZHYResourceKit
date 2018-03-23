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
    if (self == [ZHYColorWrapper class]) {
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

@implementation ZHYColorInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithColor:(ZHYColor *)color resourceName:(NSString *)resourceName {
    if (color == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceName = [resourceName copy];
        
        
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _resourceName];
    [desc appendFormat:@"<hex: %@>", _hex];
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
    if (![self.name isEqualToString:colorInfo.name]) {
        return NO;
    }
    
    if ([self.hex isEqualToString:colorInfo.hex]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYColorInfo *info = [[ZHYColorInfo allocWithZone:zone] initWithColorHex:self.hex forName:self.name];
    info.detail = self.detail;
    
    return info;
}

#pragma mark - ZHYResourceInfo Protocol

- (id)content {
    return self.hex;
}

- (void)setContent:(id)content {
    if (![content isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid content type. <content: %@>", content];
    } else {
        self.hex = content;
    }
}

- (NSDictionary *)encodeToPlist {
    if (!self.name || !self.hex) {
        return nil;
    }
    
    NSMutableDictionary *plist = [NSMutableDictionary dictionaryWithCapacity:3];
    
    [plist setObject:self.name forKey:kZHYColorKeyName];
    [plist setObject:self.hex forKey:kZHYColorKeyColorHex];
    if (self.detail) {
        [plist setObject:self.detail forKey:kZHYColorKeyDetail];
    }
    
    return plist;
}

+ (instancetype)decodeFromPlist:(NSDictionary *)plist {
    NSString *name = [plist objectForKey:kZHYColorKeyName];
    if (!name) {
        return nil;
    }
    
    NSString *hex = [plist objectForKey:kZHYColorKeyColorHex];
    if (!hex) {
        return nil;
    }
    
    ZHYColorInfo *info = [[ZHYColorInfo alloc] initWithColorHex:hex forName:name];
    NSString *detail = [plist objectForKey:kZHYColorKeyDetail];
    info.detail = detail;
    
    return info;
}

@end
