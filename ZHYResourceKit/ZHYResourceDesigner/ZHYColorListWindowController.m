//
//  ZHYColorListWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 23/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorListWindowController.h"
#import "ZHYColorWindowController.h"
#import "ZHYColorView.h"
#import "ZHYBundleLoader.h"

@interface ZHYColorListWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *colorTableView;
@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *editButton;

@property (nonatomic, strong) ZHYColorWindowController *colorWindowController;

@property (nonatomic, strong) NSArray<ZHYColorWrapper *> *colorWrappers;

@property (nonatomic, strong) ZHYColorWrapper *selectedColorWrapper;

@end

@implementation ZHYColorListWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.colorWrappers = [ZHYBundleLoader defaultLoader].allColorWrappers;
    [self.colorTableView reloadData];
    
    [self updateSelectedRow];
}

- (IBAction)editColorDidClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    [self.window beginSheet:self.colorWindowController.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSModalResponseOK) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf reload];
        }
    }];
    self.colorWindowController.colorWrapper = self.selectedColorWrapper;
}

- (IBAction)addColorButtonDidClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    [self.window beginSheet:self.colorWindowController.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSModalResponseOK) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf reload];
        }
    }];
}

- (IBAction)removeColorButtonDidClick:(id)sender {
    BOOL response = [[ZHYBundleLoader defaultLoader] removeResourceInfo:self.selectedColorWrapper.resourceInfo inClassification:kZHYResourceKeyTypeColor];
    if (response) {
        [self reload];
    }
}

- (void)reload {
    self.colorWrappers = [ZHYBundleLoader defaultLoader].allColorWrappers;
    [self.colorTableView reloadData];
    [[ZHYBundleLoader defaultLoader] synchonizePlist];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.colorWrappers.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (row >= self.colorWrappers.count) {
        return nil;
    }
    
    ZHYColorWrapper *colorWrapper = [self.colorWrappers objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"color"]) {
        static NSString * const kZHYColorIdentifier = @"kZHYColorIdentifier";
        
        ZHYColorView *colorView = [tableView makeViewWithIdentifier:kZHYColorIdentifier owner:self];
        if (!colorView) {
            colorView = [[ZHYColorView alloc] initWithFrame:NSZeroRect];
        }
        colorView.backgroundColor = colorWrapper.color;
        return colorView;
    } else {
        static NSString * const kZHYTextIdentifier = @"kZHYTextIdentifier";
        
        NSTextField *textLabel = [tableView makeViewWithIdentifier:kZHYTextIdentifier owner:self];
        if (!textLabel) {
            textLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
            textLabel.editable = NO;
            textLabel.selectable = NO;
            textLabel.drawsBackground = NO;
            textLabel.bordered = NO;
            textLabel.identifier = kZHYTextIdentifier;
        }
        
        ZHYColorInfo *info = colorWrapper.resourceInfo;
        textLabel.stringValue = ([info valueForKey:tableColumn.identifier] ? : @"");
        return textLabel;
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    [self updateSelectedRow];
}

- (void)updateSelectedRow {
    NSInteger selectedIndex = self.colorTableView.selectedRow;
    
    ZHYColorWrapper *colorWrapper = nil;
    if (selectedIndex < self.colorWrappers.count) {
        colorWrapper = [self.colorWrappers objectAtIndex:selectedIndex];
    }
    
    self.selectedColorWrapper = colorWrapper;
}

- (ZHYColorWindowController *)colorWindowController {
    if (!_colorWindowController) {
        _colorWindowController = [[ZHYColorWindowController alloc] initWithWindowNibName:@"ZHYColorWindowController"];
    }
    return _colorWindowController;
}

- (void)setSelectedColorWrapper:(ZHYColorWrapper *)selectedColorWrapper {
    _selectedColorWrapper = selectedColorWrapper;
    
    self.editButton.enabled = (_selectedColorWrapper != nil);
    self.removeButton.enabled = (_selectedColorWrapper != nil);
}

@end
