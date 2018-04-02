//
//  ZHYBundleInfoViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleInfoViewController.h"

@interface ZHYBundleInfoViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *bundleInfoTableView;

@end

@implementation ZHYBundleInfoViewController

- (instancetype)init {
    self = [super initWithNibName:@"ZHYBundleInfoViewController" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 10;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    return nil;
}

@end
