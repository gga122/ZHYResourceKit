//
//  ZHYImageWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageWrapper.h"
#import "ZHYResourceKitDefines.h"

@implementation ZHYImageWrapper

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYImageWrapper class]) {
        [ZHYImageTransformer class];
    }
}

#pragma mark - Public Property

- (ZHYImage *)image {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYImageTransformer];
}

@end

@implementation ZHYImageInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithPath:(NSString *)path forName:(NSString *)name {
    BOOL isGuard = (!path || !name);
    if (isGuard) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _path = [path copy];
        _name = [name copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _name];
    [desc appendFormat:@"<path: %@>", _path];
    if (_detail) {
        [desc appendFormat:@"<detail: %@>", _detail];
    }
    
    return desc;
}

- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[ZHYImageInfo class]]) {
        return [self isEqualToZHYImageInfo:object];
    }
    
    return NO;
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYImageInfo:(ZHYImageInfo *)imageInfo {
    if (![self.name isEqualToString:imageInfo.name]) {
        return NO;
    }
    
    if (![self.path isEqualToString:imageInfo.path]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYImageInfo *info = [[ZHYImageInfo allocWithZone:zone] initWithPath:self.path forName:self.name];
    info.detail = self.detail;
    
    return info;
}

#pragma mark - ZHYResourceInfo Protocol

- (id)content {
    return self.path;
}

- (void)setContent:(id)content {
    if (![content isKindOfClass:[NSString class]]) {
        [NSException raise:NSInternalInconsistencyException format:@"Invalid content type. <content: %@>", content];
    } else {
        self.path = content;
    }
}

- (NSDictionary *)encodeToPlist {
    if (!self.path || !self.name) {
        return nil;
    }
    
    NSMutableDictionary<NSString *, NSString *> *plist = [NSMutableDictionary dictionary];
    
    [plist setObject:self.name forKey:kZHYImageKeyName];
    [plist setObject:self.path forKey:kZHYImageKeyPath];
    if (self.detail) {
        [plist setObject:self.detail forKey:kZHYImageKeyDetail];
    }
    
    return plist;
}

+ (instancetype)decodeFromPlist:(NSDictionary *)plist {
    NSString *name = [plist objectForKey:kZHYImageKeyName];
    if (!name) {
        return nil;
    }
    
    NSString *path = [plist objectForKey:kZHYImageKeyPath];
    if (!path) {
        return nil;
    }
    
    ZHYImageInfo *info = [[ZHYImageInfo alloc] initWithPath:path forName:name];
    NSString *detail = [plist objectForKey:kZHYColorKeyDetail];
    info.detail = detail;
    
    return info;
}

@end

@implementation ZHYImageRepresentationInfo

- (instancetype)initWithImagePath:(NSString *)path {
    if (path == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _imagePath = [path copy];
    }
    
    return self;
}

@end
