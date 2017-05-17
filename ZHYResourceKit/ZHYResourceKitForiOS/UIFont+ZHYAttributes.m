//
//  UIFont+ZHYAttributes.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 17/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "UIFont+ZHYAttributes.h"

@implementation UIFont (ZHYAttributes)

+ (instancetype)fontWithAttributes:(NSDictionary<NSString *, id> *)attributes {
    if (!attributes) {
        return nil;
    }
    
    UIFontDescriptor *descriptor = [UIFontDescriptor fontDescriptorWithFontAttributes:attributes];
    if (!descriptor) {
        return nil;
    }
    
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:0.0];
    return font;
}

@end
