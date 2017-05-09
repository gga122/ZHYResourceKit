//
//  UIColor+Hex.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "UIColor+Hex.h"

@implementation UIColor (Hex)

#pragma mark - Public Methods

+ (UIColor *)colorWithHexARGB:(NSString *)hex {
    CGFloat components[4] = {0};
    BOOL succeed = [self componentsFromHex:hex red:&components[0] green:&components[1] blue:&components[2] alpha:&components[3]];
    if (!succeed) {
        return nil;
    }
    
    return [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
}

+ (BOOL)componentsFromHex:(NSString *)hex red:(out CGFloat *)r green:(out CGFloat *)g blue:(out CGFloat *)b alpha:(out CGFloat *)a {
    NSString *colorHex = [[hex stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    
    *r = 0;
    *g = 0;
    *b = 0;
    *a = 0;
    
    static NSUInteger const RGBHexLength = 3;
    static NSUInteger const ARGBHexLength = 4;
    static NSUInteger const RRGGBBHexLength = 6;
    static NSUInteger const AARRGGBBHexLength = 8;
    
    switch (hex.length) {
        case RGBHexLength: {
            *a = 1.0f;
            *r = [self componentFromHex:colorHex start:0 length:1];
            *g = [self componentFromHex:colorHex start:1 length:1];
            *b = [self componentFromHex:colorHex start:2 length:1];
        }
            break;
        case ARGBHexLength: {
            *a = [self componentFromHex:colorHex start:0 length:1];
            *r = [self componentFromHex:colorHex start:1 length:1];
            *g = [self componentFromHex:colorHex start:2 length:1];
            *b = [self componentFromHex:colorHex start:3 length:1];
        }
            break;
        case RRGGBBHexLength: {
            *a = 1.0;
            *r = [self componentFromHex:colorHex start:0 length:2];
            *g = [self componentFromHex:colorHex start:2 length:2];
            *b = [self componentFromHex:colorHex start:4 length:2];
        }
            break;
        case AARRGGBBHexLength: {
            *a = [self componentFromHex:colorHex start:0 length:2];
            *r = [self componentFromHex:colorHex start:2 length:2];
            *g = [self componentFromHex:colorHex start:4 length:2];
            *b = [self componentFromHex:colorHex start:6 length:2];
        }
            break;
        default: {
            ZHYLogError(@"Color hex '%@' is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hex);
            return NO;
        }
            break;
    }
    
    return YES;
}

+ (CGFloat)componentFromHex:(NSString *)hex start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [hex substringWithRange:NSMakeRange(start, length)];
    NSString *fullHex = (length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring]);
    unsigned hexComponent;
    [[NSScanner scannerWithString:fullHex] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

@end
