//
//  ZHYResourceBundleInfo.h
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYVersionComponents.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYResourceBundleInfo : NSObject

- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSUInteger priority;
@property (nonatomic, copy, readonly) NSString *version;

@end

@interface ZHYResourceBundleInfo (Designer)

@property (nonatomic, copy, readonly) NSString *creatorVersion;

@end

NS_ASSUME_NONNULL_END
