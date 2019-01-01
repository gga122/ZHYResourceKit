//
//  ZHYResourceBundleInitializer.h
//  ZHYResourceKit
//
//  Created by Henry on 2019/1/1.
//  Copyright © 2019 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSString * ZHYResourceBundleInitializerRegisterKey;

/**
 `ZHYResourceBundlerInitializer` describled how a `ZHYResourceBundle` init its resources.
 */
@interface ZHYResourceBundleInitializer : NSObject

- (instancetype)initWithIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *identifier;

- (nullable NSString *)bundleInfoPathWithDirectoryPath:(NSString *)path;

- (nullable NSString *)resourcePathWithDirectoryPath:(NSString *)path;



@end

NS_ASSUME_NONNULL_END
