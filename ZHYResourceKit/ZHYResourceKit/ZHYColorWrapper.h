//
//  ZHYColorWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"
#import "ZHYColorTransformer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYColorWrapper : ZHYResourceWrapper

@property (nonatomic, copy, readonly) ZHYColor *color;

@end

@interface ZHYColorInfo : NSObject <ZHYResourceInfo>

- (instancetype)initWithColor:(NSColor *)color name:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithColorHex:(NSString *)hex forName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *hex;
@property (nonatomic, copy, nullable) NSString *detail;

@end

NS_ASSUME_NONNULL_END
