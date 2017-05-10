//
//  ZHYColorWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorWindowController.h"

@interface ZHYColorWindowController ()

@property (weak) IBOutlet NSTableView *colorTableView;

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@end

@implementation ZHYColorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

@end
