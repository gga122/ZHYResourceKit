//
//  ZHYFontDetailViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/5/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYFontDetailViewController.h"

static NSArray *s_globalRowIdentifiers = nil;

@interface ZHYFontDetailViewController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *fontDetailTableView;

@end

@implementation ZHYFontDetailViewController

+ (void)initialize {
    if (self == [ZHYFontDetailViewController self]) {
        s_globalRowIdentifiers = @[@"name", @"font"];
    }
}

- (instancetype)init {
    self = [super initWithNibName:@"ZHYFontDetailViewController" bundle:nil];
    if (self) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return s_globalRowIdentifiers.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    static NSString * const kTableColumnNameIdentifier = @"name";
    static NSString * const kTableColumnAttributeIdentifier = @"attribute";
    
    if ([tableColumn.identifier isEqualToString:kTableColumnNameIdentifier]) {
        NSTextField *nameLabel = [tableView makeViewWithIdentifier:kTableColumnNameIdentifier owner:self];
        if (nameLabel == nil) {
            nameLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
            nameLabel.alignment = NSTextAlignmentRight;
            nameLabel.bordered = NO;
            nameLabel.editable = NO;
            nameLabel.selectable = NO;
        }
        
        nameLabel.stringValue = [s_globalRowIdentifiers objectAtIndex:row];
        
        return nameLabel;
    } else if ([tableColumn.identifier isEqualToString:kTableColumnAttributeIdentifier]) {
        NSString *identifier = [NSString stringWithFormat:@"%@.%@", kTableColumnAttributeIdentifier, [s_globalRowIdentifiers objectAtIndex:row]];
        __kindof NSView *view = [tableView makeViewWithIdentifier:identifier owner:self];
        
        if (row == 0) {
            NSTextField *nameTextField = nil;
            if (view == nil) {
                nameTextField = [[NSTextField alloc] initWithFrame:NSZeroRect];
                nameTextField.bordered = NO;
            }
            
            view = nameTextField;
        } else {
            
        }
        
        return view;
    } else {
        [NSException raise:NSInternalInconsistencyException format:@"'%@' did not implement column '%@'.", tableView, tableColumn];
        return nil;
    }
}

@end
