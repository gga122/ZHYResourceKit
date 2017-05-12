//
//  ZHYColorTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorTransformer.h"

#if TARGET_OS_IOS
#import "UIColor+Hex.h"
#else
#import "NSColor+Hex.h"
#endif

NSValueTransformerName const kZHYColorTransformer = @"zhy.resourceKit.transformer.color";

@implementation ZHYColorTransformer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ZHYColorTransformer *transformer = [[ZHYColorTransformer alloc] init];
        [[self class] setValueTransformer:transformer forName:kZHYColorTransformer];
    });
}

- (ZHYColor *)transformedValue:(NSString *)hex {
    return [ZHYColor colorWithHexARGB:hex];
}

- (NSString *)reverseTransformedValue:(ZHYColor *)value {
    return value.hexARGB;
}

@end
