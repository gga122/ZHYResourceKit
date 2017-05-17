//
//  UIColor+ZHYHex.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZHYHex)

+ (UIColor *)colorWithHexARGB:(NSString *)hex;

@property (nonatomic, copy, readonly) NSString *hexARGB;

@end
