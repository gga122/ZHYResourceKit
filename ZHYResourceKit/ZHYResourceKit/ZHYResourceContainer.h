//
//  ZHYResourceContainer.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 28/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZHYContainerSerializerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@class ZHYResourceWrapper, ZHYResourceContainer;

@protocol ZHYResourceContainerDelegate <NSObject>

@optional

/**
 If resource container found any resource wrapper existed, conflicted wrapper will not be `nil`.
 It's good practice to implement these delegate methods, like helps you debug.
 */
- (void)resourceContainer:(ZHYResourceContainer *)container willAddWrapper:(ZHYResourceWrapper *)resourceWrapper conflictedWrapper:(ZHYResourceWrapper *)wrapper;
- (void)resourceContainer:(ZHYResourceContainer *)container didAddWrapper:(ZHYResourceWrapper *)resourceWrapper conflictedWrapper:(ZHYResourceWrapper *)wrapper;

- (void)resourceContainer:(ZHYResourceContainer *)container willRemoveWrapper:(ZHYResourceWrapper *)resourceWrapper;
- (void)resourceContainer:(ZHYResourceContainer *)container didRemoveWrapper:(ZHYResourceWrapper *)resourceWrapper;

@end

/**
 `ZHYResourceContainer` provided basic container for different resources.
 You can NOT add/remove resource wrappers which resource type do not match.
 */
@interface ZHYResourceContainer : NSObject

- (instancetype)initWithResourceType:(NSString *)resourceType;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *resourceType;

- (void)addResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;
- (void)removeResourceWrapper:(ZHYResourceWrapper *)resourceWrapper;

@property (nonatomic, weak) id<ZHYResourceContainerDelegate> delegate;

@property (nonatomic, copy, readonly) NSArray<ZHYResourceWrapper *> *allResourceWrappers;

@end

@interface ZHYResourceContainer (Serializer) <ZHYContainerSerializerProtocol>

- (BOOL)writeToContentPath:(NSString *)contentPath;
+ (nullable instancetype)containerWithContentPath:(NSString *)contentPath;

@end

NS_ASSUME_NONNULL_END
