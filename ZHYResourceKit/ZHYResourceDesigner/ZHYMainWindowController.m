//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYMainWindowController.h"
#import "ZHYColorWindowController.h"

@interface ZHYMainWindowController ()

@property (nonatomic, strong) ZHYColorWindowController *colorWindowController;

@end

@implementation ZHYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)imageButtonDidClick:(id)sender {
    
}

- (IBAction)colorButtonDidClick:(id)sender {
    [self.colorWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)fontButtonDidClick:(id)sender {
    
}

#pragma mark - Private Property

- (ZHYColorWindowController *)colorWindowController {
    if (!_colorWindowController) {
        _colorWindowController = [[ZHYColorWindowController alloc] initWithWindowNibName:@"ZHYColorWindowController"];
    }
    
    return _colorWindowController;
}

@end
