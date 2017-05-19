//
//  ZHYImageWindowController.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ZHYBusinessViewController.h"

@interface ZHYImageWindowController : NSWindowController <ZHYBusinessViewController>

@property (nonatomic, strong) NSBundle *bundle;

@property (nonatomic, copy, readonly) NSArray<NSDictionary *> *metaInfos;

@end
