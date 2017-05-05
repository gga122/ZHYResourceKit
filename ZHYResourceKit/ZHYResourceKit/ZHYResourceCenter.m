//
//  ZHYResourceCenter.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceCenter.h"

@implementation ZHYResourceCenter

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _bundle = bundle;
    }
    
    return self;
}

#pragma mark - Overridden

- (instancetype)init {
    return [self initWithBundle:[NSBundle mainBundle]];
}

#pragma mark - Private Methods

- ()

@end
