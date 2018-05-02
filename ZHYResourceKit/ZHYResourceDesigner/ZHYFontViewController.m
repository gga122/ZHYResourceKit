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
@property (nonatomic, strong) NSArray<ZHYFontWrapper *> *allFontWrappers;

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
    return self.allFontWrappers.count + 1;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    static NSString * const kLabelIdentifier = @"labelIdentifier";
    static NSString * const kColumnNameIdentifier = @"name";
    static NSString * const kColumnDescriptionIdentifier = @"description";
    
    NSTextField *label = [tableView makeViewWithIdentifier:kLabelIdentifier owner:self];
    if (label == nil) {
        label = [[NSTextField alloc] initWithFrame:NSZeroRect];
        label.bordered = NO;
        label.editable = NO;
        label.selectable = NO;
        label.backgroundColor = [NSColor clearColor];
    }
    
    ZHYFontWrapper *fontWrapper = [self.allFontWrappers objectAtIndex:row];
    if (fontWrapper != nil) {
        if ([tableColumn.identifier isEqualToString:kColumnNameIdentifier]) {
            label.stringValue = fontWrapper.resourceName;
        } else if ([tableColumn.identifier isEqualToString:kColumnDescriptionIdentifier]) {
            if (fontWrapper.resourceDetail != nil) {
                label.stringValue = fontWrapper.resourceDetail;
            }
        }
    }
    
    return label;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (notification.object != self.fontTableView) {
        return;
    }
    
    NSInteger selectedRow = self.fontTableView.selectedRow;
    if (selectedRow < 0 || selectedRow == NSNotFound) {
        return;
    }
    
    if (selectedRow == self.fontTableView.numberOfRows - 1) {
        self.fontDetailViewController.fontWrapper = nil;
        return;
    }
    
    self.fontDetailViewController.fontWrapper = [self.allFontWrappers objectAtIndex:selectedRow];
}

#pragma mark - Private Property

- (ZHYFontDetailViewController *)fontDetailViewController {
    if (_fontDetailViewController == nil) {
        _fontDetailViewController = [[ZHYFontDetailViewController alloc] init];
    }
    
    return _fontDetailViewController;
}

@end
