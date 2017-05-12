//
//  ZHYColorTransformer.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIColor ZHYColor;
#else
#import <Cocoa/Cocoa.h>
typedef NSColor ZHYColor;
#endif

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSValueTransformerName const kZHYColorTransformer;

@interface ZHYColorTransformer : NSValueTransformer

- (nullable ZHYColor *)transformedValue:(nullable NSString *)hex;
- (nullable NSString *)reverseTransformedValue:(nullable ZHYColor *)value;

@end

NS_ASSUME_NONNULL_END
