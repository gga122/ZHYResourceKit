//
//  ZHYImageWindowController.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZHYImageWrapper.h"

@interface ZHYImageWindowController : NSWindowController

@property (nonatomic, strong) ZHYImageWrapper *imageWrapper;

@property (nonatomic, copy, readonly) ZHYImageWrapper *currentImageWrapper;

@end
