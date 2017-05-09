//
//  ZHYFontWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontWrapper.h"

@implementation ZHYFontWrapper

- (instancetype)initWithFont:(ZHYFont *)font forName:(NSString *)name detail:(NSString *)detail {
    if (!font) {
        ZHYLogError(@"font can not be nil.");
        return nil;
    }
    
    if (!name) {
        ZHYLogError(@"name can not be nil.");
    }
    
    self = [super init];
    if (self) {
        _font = [font copy];
        _name = [name copy];
        _detail = [detail copy];
    }
    
    return self;
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
