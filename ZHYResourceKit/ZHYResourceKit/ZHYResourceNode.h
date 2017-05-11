//
//  ZHYResourceNode.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString * const kZHYResourceNodeNameImage;
FOUNDATION_EXTERN NSString * const kZHYResourceNodeNameFont;

/**
 Resource node represent a hub of one type resources.
 
 Resource node is a container that contains all same type resources in the bundle. Resource center query a resource object to ask for resource node.
 */
@interface ZHYResourceNode : NSObject

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
