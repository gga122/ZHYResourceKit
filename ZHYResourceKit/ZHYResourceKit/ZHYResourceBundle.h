//
//  ZHYResourceBundle.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHYResourceWrapper;

/**
 `ZHYResourceBundle` represents a resource package which managed all related resources like image/font/color/audio and so on.
 */
@interface ZHYResourceBundle : NSObject

- (instancetype)initWithBundleName:(NSString *)bundleName priority:(NSUInteger)priority NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *bundleName;
@property (nonatomic, assign, readonly) NSUInteger priority;

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;
- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;

@property (nonatomic, copy, readonly) NSArray<NSString *> *allResourceTypes;

- (NSArray<ZHYResourceWrapper *> *)resourceWrappersForResourceType:(NSString *)resourceType;

@property (nonatomic, copy, readonly) NSDictionary<NSString *, id> *bundleInfos;

@end

@interface ZHYResourceBundle (Serializer)

- (BOOL)writeToFile:(NSString *)filePath atomically:(BOOL)atomically;
+ (instancetype)resourceBundleWithBundle:(NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
