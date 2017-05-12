//
//  ZHYFontWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYFontWrapper.h"

@implementation ZHYFontWrapper

- (ZHYFont *)font {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYFontTransformer];
}

#pragma mark - Overridden


@end
