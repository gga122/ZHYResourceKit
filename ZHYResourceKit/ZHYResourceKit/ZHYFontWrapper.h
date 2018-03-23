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

@interface ZHYFontInfo : NSObject <ZHYResourceDescriptor>

- (instancetype)initWithFont:(ZHYFont *)font resourceName:(NSString *)resourceName NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy) NSString *resourceName;
@property (nonatomic, copy) NSDictionary *descriptor;
@property (nonatomic, copy, nullable) NSString *resourceDetail;

@end

/* Keys for `descriptor` */
FOUNDATION_EXTERN NSString * const kZHYFontInfoDescriptorKeySize;
FOUNDATION_EXTERN NSString * const kZHYFontInfoDescriptorKeyAttributes;

NS_ASSUME_NONNULL_END
