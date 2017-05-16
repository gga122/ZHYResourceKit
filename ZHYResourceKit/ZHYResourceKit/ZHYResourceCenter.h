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

/**
 Resource Center designed for manager all resources in a bundle.
 
 Every bundle which can be handled by resource center MUST contain a `structure plist` file at root of `Resource` folder. Structure file describe the resource 
 structure to improve performance. 
 
 Resource center support lots of types.
 1. Color
 2. Font
 3. Image

 */
@interface ZHYResourceCenter : NSObject

- (instancetype)initWithBundle:(NSBundle *)bundle NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly) NSBundle *bundle;

@property (nonatomic, copy, readonly) NSArray<ZHYResourceNode *> *subNodes;

- (id)resourceForName:(NSString *)name ofClassification:(NSString *)classification;

@end

NS_ASSUME_NONNULL_END
