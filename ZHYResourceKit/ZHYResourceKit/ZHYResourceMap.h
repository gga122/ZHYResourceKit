//
//  ZHYResourceMap.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWrapper.h"

@class ZHYResourceWrapper;

@interface ZHYResourceMap : NSObject

+ (Class)wrapperForClassification:(NSString *)classification;
+ (Class)infoForClassification:(NSString *)classification;

+ (void)registerWrapper:(Class)wrapper forClassification:(NSString *)classification;
+ (void)unregisterWrapperForClassification:(NSString *)classification;

+ (void)registerResourceInfo:(Class<ZHYResourceInfo>)info forClassification:(NSString *)classification;
+ (void)unregisterResourceInfoForClassification:(NSString *)classification;

@end
