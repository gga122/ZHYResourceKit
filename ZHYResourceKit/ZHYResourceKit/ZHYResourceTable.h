//
//  ZHYResourceTable.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 23/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHYResourceWrapper, ZHYResourceContainer;

@interface ZHYResourceTable : NSObject

- (instancetype)initWithResourceType:(NSString *)resourceType NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *resourceType;

- (nullable ZHYResourceWrapper *)resourceWrapperForKey:(NSString *)key;

- (void)setResourceWrapper:(ZHYResourceWrapper *)wrapper forKey:(NSString *)key;
- (void)removeResourceWrapperForKey:(NSString *)key;

@property (nonatomic, copy, readonly) NSArray<ZHYResourceWrapper *> *allResourceWrappers;

@end

NS_ASSUME_NONNULL_END
