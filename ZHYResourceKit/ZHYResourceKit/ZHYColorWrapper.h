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

@interface ZHYColorInfo : NSObject <ZHYResourceDescriptor>

- (instancetype)initWithColor:(ZHYColor *)color resourceName:(NSString *)name NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, copy) NSString *representation;
@property (nonatomic, copy, nullable) NSString *resourceDetail;

@end

NS_ASSUME_NONNULL_END
