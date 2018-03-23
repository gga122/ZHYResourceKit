//
//  ZHYFontTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontTransformer.h"

#if TARGET_OS_IOS
#import "UIFont+ZHYAttributes.h"
#else
#import "NSFont+ZHYAttributes.h"
#endif

NSValueTransformerName const kZHYFontTransformer = @"zhy.resourceKit.transformer.font";

static NSString * const kZHYFontInfoKeySize = @"fontSize";
static NSString * const kZHYFontInfoKeyAttributes = @"fontAttributes";

@implementation ZHYFontTransformer

+ (void)initialize {
    if (self == [ZHYFontTransformer class]) {
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
    CGFloat fontSize = [[info objectForKey:kZHYFontInfoKeySize] doubleValue];
    NSDictionary *fontAttributes = [info objectForKey:kZHYFontInfoKeyAttributes];
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
    
    d = @{kZHYFontInfoKeySize: @(fontSize),
          kZHYFontInfoKeyAttributes: fontAttributes};
#endif
    return d;
}

@end
