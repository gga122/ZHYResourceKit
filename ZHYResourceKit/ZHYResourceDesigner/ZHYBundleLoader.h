//
//  ZHYBundleLoader.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ZHYImageWrapper.h"
#import "ZHYFontWrapper.h"
#import "ZHYColorWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYBundleLoader : NSObject

+ (instancetype)defaultLoader;

- (void)loadBundle:(nullable NSBundle *)bundle;

- (BOOL)addResourceInfo:(id<ZHYResourceInfo>)resourceInfo inClassification:(NSString *)classification;
- (BOOL)removeResourceInfo:(id<ZHYResourceInfo>)resourceInfo inClassification:(NSString *)classifitcation;

@property (nonatomic, copy, readonly) NSArray<ZHYColorWrapper *> *allColorWrappers;
@property (nonatomic, copy, readonly) NSArray<ZHYFontWrapper *> *allFontWrappers;
@property (nonatomic, copy, readonly) NSArray<ZHYImageWrapper *>*allImageWrappers;

@end

NS_ASSUME_NONNULL_END
