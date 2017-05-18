//
//  ZHYResourceWindowController.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZHYResourceWindowController : NSWindowController

- (instancetype)initWithBusinessViewController:(NSViewController *)viewController;

@property (nonatomic, strong, readonly) NSViewController *businessViewController;

@end
