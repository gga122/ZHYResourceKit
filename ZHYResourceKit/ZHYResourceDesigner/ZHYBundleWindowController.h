//
//  ZHYBundleWindowController.h
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 27/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ZHYResourceBundle;

@interface ZHYBundleWindowController : NSWindowController

- (instancetype)initWithResourceBundle:(ZHYResourceBundle *)resourceBundle;

@property (nonatomic, strong, readonly) ZHYResourceBundle *resourceBundle;

@end
