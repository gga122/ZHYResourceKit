//
//  ZHYResourceInfo.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 12/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZHYResourceInfo <NSObject>

@required

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, readonly) id content;

@property (nonatomic, copy, readonly) NSString *detail;

@end
