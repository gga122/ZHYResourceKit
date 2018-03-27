//
//  ZHYFontTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontTransformer.h"
#import "ZHYFontWrapper.h"

#if TARGET_OS_IOS
#import "UIFont+ZHYAttributes.h"
#else
#import "NSFont+ZHYAttributes.h"
#endif

NSValueTransformerName const kZHYFontTransformer = @"zhy.resourcekit.transformer.font";

@implementation ZHYFontTransformer

+ (void)initialize {
    if (self == [ZHYFontTransformer self]) {
        ZHYFontTransformer *transformer = [[ZHYFontTransformer alloc] init];
        [[self class] setValueTransformer:transformer forName:kZHYFontTransformer];
    }
}

+ (Class)transformedValueClass {
    return [ZHYFont class];
}

+ (BOOL)allowsReverseTransformation {
    return YES;
}

- (nullable ZHYFont *)transformedValue:(nullable NSDictionary *)info {
    ZHYFont *font = nil;

#if TARGET_OS_IOS
    
#else
    CGFloat fontSize = [[info objectForKey:kZHYFontInfoDescriptorKeySize] doubleValue];
    NSDictionary *fontAttributes = [info objectForKey:kZHYFontInfoDescriptorKeyAttributes];
    NSFontDescriptor *fontDescriptor = [NSFontDescriptor fontDescriptorWithFontAttributes:fontAttributes];
    
    font = [NSFont fontWithDescriptor:fontDescriptor size:fontSize];
#endif
    return font;
}

- (nullable NSDictionary *)reverseTransformedValue:(nullable ZHYFont *)font {
    NSDictionary *d = nil;

#if TARGET_OS_IOS
    
#else
    NSDictionary *fontAttributes = font.fontDescriptor.fontAttributes;
    CGFloat fontSize = font.pointSize;
    
    d = @{kZHYFontInfoDescriptorKeySize: @(fontSize),
          kZHYFontInfoDescriptorKeyAttributes: fontAttributes};
#endif
    return d;
}

@end
