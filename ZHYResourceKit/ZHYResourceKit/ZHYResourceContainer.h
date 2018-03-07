//
//  ZHYResourceContainer.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 28/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHYResourceWrapper, ZHYResourceContainer;

@protocol ZHYResourceContainerDelegate <NSObject>

@optional

- (void)resourceContainer:(ZHYResourceContainer *)container willAddWrapper:(ZHYResourceWrapper *)resourceWrapper conflictedWrapper:(ZHYResourceWrapper *)wrapper;
- (void)resourceContainer:(ZHYResourceContainer *)container didAddWrapper:(ZHYResourceWrapper *)resourceWrapper conflictedWrapper:(ZHYResourceWrapper *)wrapper;

- (void)resourceContainer:(ZHYResourceContainer *)container willRemoveWrapper:(ZHYResourceWrapper *)resourceWrapper;
- (void)resourceContainer:(ZHYResourceContainer *)container didRemoveWrapper:(ZHYResourceWrapper *)resourceWrapper;

@end

@interface ZHYResourceContainer : NSObject

- (instancetype)initWithResourceType:(NSString *)resourceType;

@property (nonatomic, copy, readonly) NSString *resourceType;

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;
- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;

@property (nonatomic, weak) id<ZHYResourceContainerDelegate> delegate;

@property (nonatomic, copy, readonly) NSArray<ZHYResourceWrapper *> *allResourceWrappers;

@end

NS_ASSUME_NONNULL_END
