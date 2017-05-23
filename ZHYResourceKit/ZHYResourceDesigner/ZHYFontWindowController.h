//
//  ZHYFontWindowController.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZHYFontWrapper.h"

@interface ZHYFontWindowController : NSWindowController

@property (nonatomic, strong) ZHYFontWrapper *fontWrapper;

@property (nonatomic, copy, readonly) ZHYFontWrapper *currentFontWrapper;

@end
