//
//  NSFont+ZHYAttributes.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 17/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSFont (ZHYAttributes)

+ (instancetype)fontWithAttributes:(NSDictionary<NSString *, id> *)attributes;

@end
