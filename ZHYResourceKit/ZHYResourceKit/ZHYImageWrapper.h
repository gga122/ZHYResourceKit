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

@end

@interface ZHYImageInfo : NSObject <ZHYResourceInfo>

- (instancetype)initWithPath:(NSString *)path forName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy, nullable) NSString *detail;

@end

NS_ASSUME_NONNULL_END
