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

- (ZHYImage *)image {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYImageTransformer];
}

@end

@implementation ZHYImageInfo

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
