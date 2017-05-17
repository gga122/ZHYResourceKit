//
//  ZHYColorTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorTransformer.h"

#if TARGET_OS_IOS
#import "UIColor+ZHYHex.h"
#else
#import "NSColor+ZHYHex.h"
#endif

NSValueTransformerName const kZHYColorTransformer = @"zhy.resourceKit.transformer.color";

@implementation ZHYColorTransformer

+ (void)initialize {
    if (self == [ZHYColorTransformer class]) {
        ZHYColorTransformer *transformer = [[ZHYColorTransformer alloc] init];
        [NSValueTransformer setValueTransformer:transformer forName:kZHYColorTransformer];
    }
}

+ (Class)transformedValueClass {
    return [ZHYColor class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (ZHYColor *)transformedValue:(NSString *)hex {
    return [ZHYColor colorWithHexARGB:hex];
}

- (NSString *)reverseTransformedValue:(ZHYColor *)color {
    return color.hexARGB;
}

@end
