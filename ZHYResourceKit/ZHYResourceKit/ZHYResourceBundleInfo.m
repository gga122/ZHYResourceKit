//
//  ZHYResourceBundleInfo.m
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceBundleInfo.h"

ZHYResourceBundleInfoAttributeKey const kZHYResourceBundleMagic = @"zhy.resourcekit.bundle.magic";
ZHYResourceBundleInfoAttributeKey const kZHYResourceBundleName = @"zhy.resourcekit.bundle.name";
ZHYResourceBundleInfoAttributeKey const kZHYResourceBundlePriority = @"zhy.resourcekit.bundle.priority";

@implementation ZHYResourceBundleInfo

#pragma mark - DESIGNATED INITIALIZER

- (nullable instancetype)initWithIdentifier:(NSString *)identifier {
    if (identifier == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _identifier = [identifier copy];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:[super description]];
    
    
    
    return description;
}


@end
