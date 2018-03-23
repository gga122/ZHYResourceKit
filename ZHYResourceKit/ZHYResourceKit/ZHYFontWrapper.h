//
//  ZHYFontWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"
#import "ZHYFontTransformer.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZHYFontWrapper : ZHYResourceWrapper

@property (nonatomic, copy, readonly) ZHYFont *font;

@end

@interface ZHYFontInfo : NSObject <ZHYResourceInfo, ZHYResourceDescriptor>

- (instancetype)initWithFont:(NSFont *)font resourceName:(NSString *)resourceName NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDictionary *descriptor;
@property (nonatomic, copy) NSString *detail;

- (instancetype)initWithDescriptor:(NSDictionary *)descriptor forName:(NSString *)name NS_DESIGNATED_INITIALIZER;

@end

/* Keys for `descriptor` */
FOUNDATION_EXTERN NSString * const kZHYFontInfoDescriptorKeySize;
FOUNDATION_EXTERN NSString * const kZHYFontInfoDescriptorKeyAttributes;

NS_ASSUME_NONNULL_END
