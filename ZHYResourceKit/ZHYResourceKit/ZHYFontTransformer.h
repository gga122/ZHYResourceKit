//
//  ZHYFontTransformer.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIFont ZHYFont;
#else
#import <Cocoa/Cocoa.h>
typedef NSFont ZHYFont;
#endif

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSValueTransformerName const kZHYFontTransformer;

@interface ZHYFontTransformer : NSValueTransformer

- (nullable ZHYFont *)transformedValue:(nullable NSDictionary *)info;
- (nullable NSDictionary *)reverseTransformedValue:(nullable ZHYFont *)font;

@end

NS_ASSUME_NONNULL_END
