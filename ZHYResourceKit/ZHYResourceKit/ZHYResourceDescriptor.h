//
//  ZHYResourceDescriptor.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 23/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZHYResourceDescriptor <NSObject, NSCopying, NSCoding>

@required

@property (nonatomic, copy) NSString *resourceName;

/* For describe the contents about resource, this could be the true data about resource, etc 'string'.
   It also could be the reference data about resource, like path about resource. */
@property (nonatomic, strong) id<NSCoding> resourceContents;

/**
 For detail description about the resource, I recommend developers do not ignore this.
 */
@property (nonatomic, copy, nullable) NSString *resourceDetail;

/**
 For describe which kind of resource, you can define your own resource type or use defined by this framework.
 */
@property (nonatomic, class, readonly) NSString *resourceType;

@optional

/**
 Create an `json/property list` info about resource descriptor.
 */
- (NSDictionary *)humanReadableInfo;

@end

NS_INLINE BOOL isValidResourceDescriptor(id<ZHYResourceDescriptor> resourceDescriptor) {
    if (resourceDescriptor == nil) {
        return NO;
    }
    
    if (resourceDescriptor.name == nil) {
        return NO;
    }
    
    return YES;
}

NS_ASSUME_NONNULL_END
