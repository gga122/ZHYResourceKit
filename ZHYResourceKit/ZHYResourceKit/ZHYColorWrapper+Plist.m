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

#if TARGET_OS_IOS
#import "UIColor+Hex.h"
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
    ZHYColor *color;
#if TARGET_OS_IOS
    color = [UIColor colorWithHexARGB:colorHex];
#else
    color = [NSColor colorWithHexARGB:colorHex];
#endif
    if (!color) {
        return nil;
    }
    
    NSString *detail = [plist objectForKey:kZHYColorKeyDetail];
    
    return [self initWithColor:color forName:name detail:detail];
}

@end
