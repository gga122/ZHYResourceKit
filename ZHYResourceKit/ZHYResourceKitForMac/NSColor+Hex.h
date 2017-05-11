//
//  NSColor+Hex.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSColor (Hex)

+ (NSColor *)colorWithHexARGB:(NSString *)hex;

@property (nonatomic, copy, readonly) NSString *hexARGB;

@end
