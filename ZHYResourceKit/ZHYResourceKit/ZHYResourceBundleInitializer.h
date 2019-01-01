//
//  ZHYResourceBundleInitializer.h
//  ZHYResourceKit
//
//  Created by Henry on 2019/1/1.
//  Copyright © 2019 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `ZHYResourceBundlerInitializer` describled how a `ZHYResourceBundle` init its resources.
 */
@interface ZHYResourceBundleInitializer : NSObject

- (instancetype)initWithIdentifier:(NSString *)identifier;

@property (nonatomic, copy, readonly) NSString *identifier;

- (BOOL)isValidBundleInfoAttributes:(NSDictionary<NSString *, id> *)bundleInfoAttributes;


@end

NS_ASSUME_NONNULL_END
