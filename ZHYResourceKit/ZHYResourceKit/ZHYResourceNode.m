//
//  ZHYResourceNode.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceNode.h"

@implementation ZHYResourceNode

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithName:(NSString *)name {
    if (!name) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    
    return self;
}

@end
