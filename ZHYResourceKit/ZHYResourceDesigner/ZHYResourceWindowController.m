//
//  ZHYResourceWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWindowController.h"

@interface ZHYResourceWindowController ()

@property (weak) IBOutlet NSView *contentView;

@end

@implementation ZHYResourceWindowController

- (instancetype)initWithBusinessViewController:(NSViewController *)viewController {
    self = [super initWithWindowNibName:@"ZHYResourceWindowController"];
    if (self) {
        _businessViewController = viewController;
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.contentView addSubview:self.businessViewController.view];
}

- (IBAction)addButtonDidClick:(id)sender {
    
}

- (IBAction)removeButtonDidClick:(id)sender {
    
}

@end
