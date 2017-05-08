//
//  ZHYResourceNode+Private.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <objc/runtime.h>
#import "ZHYResourceNode+Private.h"

static char * const pZHYResourceNodeKeyCenter = "pZHYResourceNodeKeyCenter";

@implementation ZHYResourceNode (Private)

- (void)setCenter:(ZHYResourceCenter *)center {
    objc_setAssociatedObject(self, pZHYResourceNodeKeyCenter, center, OBJC_ASSOCIATION_ASSIGN);
}

- (ZHYResourceCenter *)center {
    return objc_getAssociatedObject(self, pZHYResourceNodeKeyCenter);
}

@end
