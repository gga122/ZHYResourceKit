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



#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _name];
    [desc appendFormat:@"<font: %@>", _font];
    if (_detail) {
        [desc appendFormat:@"<detail: %@>", _detail];
    }
    
    return desc;
}

@end
