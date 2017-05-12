//
//  ZHYImageWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageWrapper.h"

@implementation ZHYImageWrapper

- (instancetype)initWithImage:(ZHYImage *)image forName:(NSString *)name detail:(NSString *)detail {
    if (!image) {
        ZHYLogError(@"image can not be nil.");
        return nil;
    }
    
    if (!name) {
        ZHYLogError(@"name can not be nil.");
    }
    
    self = [super init];
    if (self) {
        _image = image;
        _name = [name copy];
        _detail = [detail copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _name];
    [desc appendFormat:@"<image: %@>", _image];
    if (_detail) {
        [desc appendFormat:@"<detail: %@>", _detail];
    }
    
    return desc;
}

@end

@implementation ZHYImageInfo

- (instancetype)initWithPath:(NSString *)path forName:(NSString *)name {
    BOOL isGuard = (!path || !name);
    if (isGuard) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _path = [path copy];
        _name = [name copy];
    }
    
    return self;
}



@end
