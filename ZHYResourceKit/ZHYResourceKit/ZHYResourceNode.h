//
//  ZHYResourceNode.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Resource node represent a hub of one type resources.
 
 Resource node is a container that contains all same type resources in the bundle. Resource center query a resource object to ask for resource node.
 */
@interface ZHYResourceNode : NSObject

- (instancetype)initWithClassification:(NSString *)classification metaInfos:(NSArray<NSDictionary *> *)metaInfos NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *classification;

- (id)resourceForName:(NSString *)name;

@property (nonatomic, copy, readonly) NSArray<NSDictionary *> *metaInfos;

@end

NS_ASSUME_NONNULL_END
