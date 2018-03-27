//
//  ZHYImageWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"
#import "ZHYImageTransformer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYImageWrapper : ZHYResourceWrapper

@property (nonatomic, strong, readonly) ZHYImage *image;

- (ZHYImage *)imageForScale:(CGFloat)scale;

@end

@interface ZHYImageInfo : NSObject <ZHYResourceDescriptor>

- (instancetype)initWithImagePath:(NSString *)path forResourceName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

- (nullable NSString *)imagePathForScale:(CGFloat)scale;

- (void)setImagePath:(NSString *)path forScale:(CGFloat)scale;
- (void)removeImagePathForScale:(CGFloat)scale;

@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, copy, readonly) NSDictionary *imagePaths;
@property (nonatomic, copy, nullable) NSString *resourceDetail;

@end

NS_ASSUME_NONNULL_END
