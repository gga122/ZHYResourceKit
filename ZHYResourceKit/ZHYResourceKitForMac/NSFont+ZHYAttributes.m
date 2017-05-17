//
//  NSFont+ZHYAttributes.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 17/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "NSFont+ZHYAttributes.h"

@implementation NSFont (ZHYAttributes)

+ (instancetype)fontWithAttributes:(NSDictionary<NSString *,id> *)attributes {
    NSFontDescriptor *fontDescriptor = [[NSFontDescriptor alloc] initWithFontAttributes:attributes];
    
    if (!fontDescriptor) {
        return nil;
    }
    
    NSFont *font = [NSFont fontWithDescriptor:fontDescriptor size:0.0];
    return font;
}

- (NSDictionary<NSString *,id> *)attributes {
    return self.fontDescriptor.fontAttributes;
}

@end
