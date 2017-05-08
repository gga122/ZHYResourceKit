//
//  ZHYResourceManager.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHYResourceManager : NSObject

+ (instancetype)defaultManager;

- (BOOL)loadConfigurations:(NSString *)filePath;
- (void)unloadConfigurations;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, NSDictionary *> *configurations;

- (BOOL)loadbundle:(NSString *)bundleKey;
@property (nonatomic, copy, readonly) NSString *currentBundle;

@end

NS_ASSUME_NONNULL_END
