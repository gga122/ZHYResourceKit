//
//  ZHYResourceBundle.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `ZHYResourceBundle` represents a resource package which managed all related resources like image/font/color/audio and so on.
 */
@interface ZHYResourceBundle : NSObject <NSCoding>

- (instancetype)initWithBundleName:(NSString *)bundleName priority:(NSUInteger)priority NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *bundleName;
@property (nonatomic, assign, readonly) NSUInteger priority;

- (void)addResourceType:(NSString *)resourceType;
- (void)removeResourceType:(NSString *)resourceType;
@property (nonatomic, copy, readonly) NSArray<NSString *> *allResourceTypes;

@end
