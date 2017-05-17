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
    ZHYFont *font = [ZHYFont fontWithAttributes:info];
}

- (nullable NSDictionary *)reverseTransformedValue:(nullable ZHYFont *)font {
    return nil;
}

@end
