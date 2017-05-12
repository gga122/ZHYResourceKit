//
//  ZHYColorWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"

@implementation ZHYColorWrapper 

#pragma mark - Public Property

- (ZHYColor *)color {
    return [self.resource copy];
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYColorTransformer];
}

@end
