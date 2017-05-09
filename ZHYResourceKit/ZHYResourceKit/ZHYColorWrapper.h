//
//  ZHYColorWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
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

@interface ZHYColorWrapper : NSObject

- (instancetype)initWithColor:(ZHYColor *)color forName:(NSString *)name detail:(nullable NSString *)detail NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) ZHYColor *color;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *detail;

@end

NS_ASSUME_NONNULL_END
