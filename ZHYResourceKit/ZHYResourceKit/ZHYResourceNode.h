//
//  ZHYResourceNode.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHYResourceNode : NSObject

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
