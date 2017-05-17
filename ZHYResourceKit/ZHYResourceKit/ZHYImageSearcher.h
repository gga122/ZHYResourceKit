//
//  ZHYImageSearcher.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYImageWrapper.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYImageSearcher : NSObject

- (instancetype)initWithBundle:(nullable NSBundle *)bundle NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong, readonly, nullable) NSBundle *bundle;

@property (nonatomic, copy, readonly, nullable) NSArray<ZHYImageInfo *> *infos;
@property (nonatomic, copy, readonly, nullable) NSArray<NSDictionary *> *metaInfos;

+ (NSArray<NSString *> *)imageFilters;
+ (void)setImageFilters:(NSArray<NSString *> *)imageFilters;

@end

NS_ASSUME_NONNULL_END
