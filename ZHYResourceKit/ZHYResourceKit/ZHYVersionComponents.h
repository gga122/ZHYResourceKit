//
//  ZHYVersionComponents.h
//  ZHYResourceKit
//
//  Created by Henry on 2018/10/21.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZHYVersionComponents : NSObject <NSCopying, NSSecureCoding>

- (nullable instancetype)initWithVersionValue:(NSString *)versionValue NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, readonly) NSString *versionValue;

@property (nonatomic, copy, readonly) NSString *majorValue;
@property (nonatomic, copy, readonly) NSString *minorValue;
@property (nonatomic, copy, readonly) NSString *patchValue;
@property (nonatomic, copy, readonly) NSString *buildValue;

@property (nonatomic, assign, readonly) NSInteger major;
@property (nonatomic, assign, readonly) NSInteger minor;
@property (nonatomic, assign, readonly) NSInteger patch;
@property (nonatomic, assign, readonly) NSInteger build;

- (NSComparisonResult)compare:(ZHYVersionComponents *)components;

@end

NS_ASSUME_NONNULL_END
