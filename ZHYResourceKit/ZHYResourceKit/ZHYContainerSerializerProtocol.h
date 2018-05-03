//
//  ZHYContainerSerializerProtocol.h
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 3/5/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZHYContainerSerializerProtocol <NSObject>

@required

- (BOOL)writeToContentPath:(NSString *)contentPath;
+ (nullable instancetype)containerWithContentPath:(NSString *)contentPath;

@end
