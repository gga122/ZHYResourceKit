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

@interface ZHYFontInfo : NSObject <ZHYResourceInfo>



@end

NS_ASSUME_NONNULL_END
