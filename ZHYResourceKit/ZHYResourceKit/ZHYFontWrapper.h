//
//  ZHYFontWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
typedef UIFont ZHYFont;
#else
#import <Cocoa/Cocoa.h>
typedef NSFont ZHYFont;
#endif

@interface ZHYFontWrapper : NSObject

- (instancetype)initWithFont:(ZHYFont *)font forName:(NSString *)name detail:(NSString *)detail NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) ZHYFont *font;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *detail;

@end