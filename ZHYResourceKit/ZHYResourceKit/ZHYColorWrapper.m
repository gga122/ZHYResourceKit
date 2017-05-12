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

#pragma mark - Public Property

- (ZHYColor *)color {
    return [self.resource copy];
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYColorTransformer];
}

@end

@implementation ZHYColorInfo

- (instancetype)initWithColorHex:(NSString *)hex forName:(NSString *)name {
    BOOL isGuard = (!hex || !name);
    if (isGuard) {
        return nil;
    }

    self = [super init];
    if (self) {
        _name = [name copy];
        _hex = [hex copy];
    }
    
    return self;
}

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

@end
