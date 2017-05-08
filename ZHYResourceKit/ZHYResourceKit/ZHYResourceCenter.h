//
//  ZHYResourceCenter.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYResourceNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYResourceCenter : NSObject

- (instancetype)initWithBundle:(NSBundle *)bundle NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly) NSBundle *bundle;

@property (nonatomic, copy, readonly) NSArray<ZHYResourceNode *> *subNodes;

@end

NS_ASSUME_NONNULL_END
