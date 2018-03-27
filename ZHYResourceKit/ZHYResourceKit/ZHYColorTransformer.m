//
//  ZHYColorTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <CoreImage/CoreImage.h>

#import "ZHYColorTransformer.h"

#if TARGET_OS_IOS
#import "UIColor+ZHYHex.h"
#else
#import "NSColor+ZHYHex.h"
#endif

NSValueTransformerName const kZHYColorTransformer = @"zhy.resourcekit.transformer.color";

@implementation ZHYColorTransformer

+ (void)initialize {
    if (self == [ZHYColorTransformer self]) {
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

- (nullable ZHYColor *)transformedValue:(nullable NSString *)colorRepresetation {
    if (colorRepresetation == nil) {
        return nil;
    }
    
    CIColor *c = [CIColor colorWithString:colorRepresetation];
    if (c == nil) {
        return nil;
    }
    
    ZHYColor *color = nil;
#if TARGET_OS_IOS
    color = [[ZHYColor alloc] initWithCIColor:c];
#else
    color = [ZHYColor colorWithCIColor:c];
#endif
    
    return color;
}

- (NSString *)reverseTransformedValue:(ZHYColor *)color {
    if (color == nil) {
        return nil;
    }
    
    CIColor *c = nil;
#if TARGET_OS_IOS
    c = [[CIColor alloc] initWithColor:color];
#else
    c = [[CIColor alloc] initWithColor:color];
#endif
    
    return c.stringRepresentation;
}

@end
