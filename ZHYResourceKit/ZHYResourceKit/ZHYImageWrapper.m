//
//  ZHYImageWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageWrapper.h"

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

@end
