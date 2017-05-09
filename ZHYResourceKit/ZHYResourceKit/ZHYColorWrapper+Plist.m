//
//  ZHYColorWrapper+Plist.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYColorWrapper+Plist.h"
#import "ZHYResourceKitDefines.h"

#if TARGET_OS_IPHONE

#else
#import "NSColor+Hex.h"
#endif

@implementation ZHYColorWrapper (Plist)

#pragma mark - Public Methods

- (instancetype)initWithPlist:(NSDictionary<NSString *, NSString *> *)plist {
    NSString *name = [plist objectForKey:kZHYColorKeyName];
    if (!name) {
        return nil;
    }
    
    NSString *colorHex = [plist objectForKey:kZHYColorKeyColorHex];
    
}

@end
