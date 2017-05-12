//
//  ZHYResourceWrapper.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZHYResourceInfo <NSObject>

@required

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id content;

@property (nonatomic, copy, nullable) NSString *detail;

- (NSDictionary *)encodeToPlist;
+ (instancetype)decodeFromPlist:(NSDictionary *)plist;

@end


@interface ZHYResourceWrapper : NSObject

- (instancetype)initWithResourceInfo:(id<ZHYResourceInfo>)info NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly, nullable) id resource;
@property (nonatomic, copy, readonly, nullable) NSString *detail;

/**
 For subclass overridden
 */
@property (nonatomic, class, readonly, nullable) NSValueTransformer *transformer;

@end

NS_ASSUME_NONNULL_END
