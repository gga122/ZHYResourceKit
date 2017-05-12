//
//  ZHYImageWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
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

@interface ZHYImageWrapper : NSObject

- (instancetype)initWithImage:(ZHYImage *)image forName:(NSString *)name detail:(nullable NSString *)detail NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly) ZHYImage *image;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly, nullable) NSString *detail;

@end

@interface ZHYImageInfo : NSObject

- (instancetype)initWithPath:(NSString *)path forName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy, nullable) NSString *detail;

@end

NS_ASSUME_NONNULL_END
