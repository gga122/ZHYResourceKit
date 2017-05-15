//
//  ZHYImageTransformer.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIImage ZHYImage;
#else
#import <Cocoa/Cocoa.h>
typedef NSImage ZHYImage;
#endif

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSValueTransformerName const kZHYImageTransformer;

@interface ZHYImageTransformer : NSValueTransformer

- (nullable ZHYImage *)transformedValue:(nullable NSString *)path;
- (nullable NSString *)reverseTransformedValue:(nullable ZHYImage *)image NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
