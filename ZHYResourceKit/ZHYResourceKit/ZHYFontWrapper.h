//
//  ZHYFontWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIFont ZHYFont;
#else
#import <Cocoa/Cocoa.h>
typedef NSFont ZHYFont;
#endif

NS_ASSUME_NONNULL_BEGIN

@interface ZHYFontWrapper : ZHYResourceWrapper

- (instancetype)initWithFont:(ZHYFont *)font forName:(NSString *)name detail:(nullable NSString *)detail NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) ZHYFont *font;

@end

@interface ZHYFontInfo : NSObject <ZHYResourceInfo>

- (instancetype)initWithColorHex:(NSString *)hex forName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hex;
@property (nonatomic, copy) NSString *detail;

@end


NS_ASSUME_NONNULL_END
