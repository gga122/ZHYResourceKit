//
//  ZHYResourceMap.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZHYResourceWrapper;

@interface ZHYResourceMap : NSObject

+ (void)registerWrapper:(Class)wrapper forClassification:(NSString *)classification;
+ (void)unregisterWrapperForClassification:(NSString *)classification;

+ (void)registerResourceInfo:(Class)info forClassification:(NSString *)classification;
+ (void)unregisterResourceInfoForClassification:(NSString *)classification;

@end
