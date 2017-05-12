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
        ZHYLogError(@"color name is nil");
        return nil;
    }
    
    NSString *colorHex = [plist objectForKey:kZHYColorKeyColorHex];
    ZHYColor *color = [ZHYColor colorWithHexARGB:colorHex];
    if (!color) {
        ZHYLogError(@"color hex is nil");
        return nil;
    }
    
    NSString *detail = [plist objectForKey:kZHYColorKeyDetail];
    
    return [self initWithColor:color forName:name detail:detail];
}

- (NSDictionary<NSString *, NSString *> *)colorWrapperPlist {
    NSMutableDictionary<NSString *, NSString *> *plist = [NSMutableDictionary dictionary];
    
    [plist setObject:self.name forKey:kZHYColorKeyName];
    NSString *hex = self.color.hexARGB;
    if (!hex) {
        return nil;
    }
    [plist setObject:hex forKey:kZHYColorKeyColorHex];
    
    if (self.detail) {
        [plist setObject:self.detail forKey:kZHYColorKeyDetail];
    }
    
    return plist;
}

@end
