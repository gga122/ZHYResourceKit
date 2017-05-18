//
//  ZHYResourceNode+Private.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceNode.h"
#import "ZHYResourceWrapper.h"

@interface ZHYResourceNode (Private)

- (BOOL)addResourceInfo:(id<ZHYResourceInfo>)resourceInfo;
- (BOOL)removeResourceInfo:(id<ZHYResourceInfo>)resourceInfo;

- (NSArray<NSDictionary<NSString *, id> *> *)archiveToPlist;

@end
