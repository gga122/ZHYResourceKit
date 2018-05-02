//
//  ZHYFontViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/5/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYFontViewController.h"

@interface ZHYFontViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *fontTableView;

@end

@implementation ZHYFontViewController

- (instancetype)init {
    self = [super initWithNibName:@"ZHYFontViewController" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 1;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return nil;
}

@end
