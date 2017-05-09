//
//  ZHYColorWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYColorWrapper.h"

@implementation ZHYColorWrapper

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithColor:(ZHYColor *)color forName:(NSString *)name detail:(NSString *)detail {
    if (!color) {
        ZHYLogError(@"color can not be nil.");
        return nil;
    }
    
    if (!name) {
        ZHYLogError(@"name can not be nil.");
    }
    
    self = [super init];
    if (self) {
        _color = [color copy];
        _name = [name copy];
        _detail = [detail copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _name];
    [desc appendFormat:@"<color: %@>", _color];
    if (_detail) {
        [desc appendFormat:@"<detail: %@>", _detail];
    }
        
    return desc;
}

@end
