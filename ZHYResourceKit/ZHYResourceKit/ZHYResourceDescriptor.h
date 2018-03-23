//
//  ZHYResourceDescriptor.h
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 23/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZHYResourceDescriptor <NSObject, NSCopying, NSCoding>

@required

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) id<NSCoding> contents;

@property (nonatomic, copy, nullable) NSString *detail;

@optional

- (NSDictionary *)humanReadableInfo;

@end
