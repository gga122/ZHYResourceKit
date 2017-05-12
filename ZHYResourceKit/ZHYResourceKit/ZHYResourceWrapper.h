//
//  ZHYResourceWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceInfo.h"

@interface ZHYResourceWrapper : NSObject

- (instancetype)initWithResourceInfo:(id<ZHYResourceInfo>)info NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly) id resource;
@property (nonatomic, copy, readonly) NSString *detail;

/**
 For subclass overridden
 */
@property (nonatomic, strong, readonly) NSValueTransformer *transformer;

@end
