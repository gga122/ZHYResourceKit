//
//  ZHYResourceWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ZHYResourceKitForMac/ZHYResourceDescriptor.h>

NS_ASSUME_NONNULL_BEGIN

/**
 `ZHYResourceWrapper` is an abstract class for wrapping a resource object. Dont use this class directly.
 */
@interface ZHYResourceWrapper : NSObject <NSCopying, NSCoding>

- (instancetype)initWithResourceDescriptor:(id<ZHYResourceDescriptor>)descriptor NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly) id<ZHYResourceDescriptor> resourceDescriptor;

@property (nonatomic, copy, readonly) NSString *resourceName;
@property (nonatomic, copy, readonly, nullable) id resource;
@property (nonatomic, copy, readonly, nullable) NSString *resourceDetail;
@property (nonatomic, copy, readonly) NSString *resourceType;

/**
 For subclass overridden
 */
@property (nonatomic, class, readonly, nullable) NSValueTransformer *transformer;

@end

NS_ASSUME_NONNULL_END
