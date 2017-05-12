//
//  ZHYFontTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontTransformer.h"

NSValueTransformerName const kZHYFontTransformer = @"zhy.resourceKit.transformer.font";

@implementation ZHYFontTransformer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ZHYFontTransformer *transformer = [[ZHYFontTransformer alloc] init];
        [[self class] setValueTransformer:transformer forName:kZHYFontTransformer];
    });
}

- (nullable ZHYFont *)transformedValue:(nullable NSDictionary *)info {
    return nil;
}

- (nullable NSDictionary *)reverseTransformedValue:(nullable ZHYFont *)font {
    return nil;
}

@end
