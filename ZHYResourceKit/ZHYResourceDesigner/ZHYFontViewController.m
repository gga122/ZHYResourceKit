//
//  ZHYFontViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/5/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYFontViewController.h"
#import "ZHYFontDetailViewController.h"

@interface ZHYFontViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *fontTableView;
@property (weak) IBOutlet NSBox *fontDetailViewBox;

@property (nonatomic, strong) ZHYFontDetailViewController *fontDetailViewController;

@end

@implementation ZHYFontViewController

- (instancetype)init {
    self = [super initWithNibName:@"ZHYFontViewController" bundle:nil];
    if (self) {
        _fontDetailViewController = [[ZHYFontDetailViewController alloc] init];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.fontDetailViewBox.contentView = self.fontDetailViewController.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return 1;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableView.numberOfRows == row + 1) {
        // TODO:
    }
    
    
    return nil;
}

#pragma mark - Private Property

- (ZHYFontDetailViewController *)fontDetailViewController {
    if (_fontDetailViewController == nil) {
        _fontDetailViewController = [[ZHYFontDetailViewController alloc] init];
    }
    
    return _fontDetailViewController;
}

@end
