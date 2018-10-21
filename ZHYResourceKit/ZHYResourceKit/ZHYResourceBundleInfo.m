//
//  ZHYResourceBundleInfo.m
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceBundleInfo.h"

@implementation ZHYResourceBundleInfo

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


@end
