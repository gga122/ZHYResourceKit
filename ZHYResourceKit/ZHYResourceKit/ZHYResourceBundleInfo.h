//
//  ZHYResourceBundleInfo.h
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYVersionComponents.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString * ZHYResourceBundleInfoAttributeKey;

@interface ZHYResourceBundleInfo : NSObject <NSSecureCoding>

- (nullable instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSUInteger priority;
@property (nonatomic, copy, readonly) ZHYVersionComponents *version;

@end

@interface ZHYResourceBundleInfo (Designer)

@property (nonatomic, copy, readonly) ZHYVersionComponents *creatorVersion;

@end

FOUNDATION_EXPORT ZHYResourceBundleInfoAttributeKey const kZHYResourceBundleMagic;
FOUNDATION_EXPORT ZHYResourceBundleInfoAttributeKey const kZHYResourceBundleName;
FOUNDATION_EXPORT ZHYResourceBundleInfoAttributeKey const kZHYResourceBundlePriority;

NS_ASSUME_NONNULL_END
