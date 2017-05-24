//
//  ZHYFontListWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 23/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontListWindowController.h"
#import "ZHYFontWindowController.h"
#import "ZHYBundleLoader.h"

@interface ZHYFontListWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *fontTableView;

@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *editButton;

@property (nonatomic, strong) ZHYFontWindowController *fontWindowController;

@property (nonatomic, strong) NSArray<ZHYFontWrapper *> *fontWrappers;

@property (nonatomic, strong) ZHYFontWrapper *selectedFontWrapper;

@end

@implementation ZHYFontListWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.fontWrappers = [ZHYBundleLoader defaultLoader].allFontWrappers;
    [self.fontTableView reloadData];
}

- (IBAction)addFontButtonDidClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    [self.window beginSheet:self.fontWindowController.window completionHandler:^(NSModalResponse returnCode) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf reload];
    }];
}

- (IBAction)removeFontButtonDidClick:(id)sender {
    BOOL response = [[ZHYBundleLoader defaultLoader] removeResourceInfo:self.selectedFontWrapper.resourceInfo inClassification:kZHYResourceKeyTypeFont];
    if (response) {
        [self reload];
    }
}

- (IBAction)editFontButtonDidClick:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    [self.window beginSheet:self.fontWindowController.window completionHandler:^(NSModalResponse returnCode) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf reload];
    }];
    
    self.fontWindowController.fontWrapper = self.selectedFontWrapper;
}

- (void)reload {
    self.fontWrappers = [ZHYBundleLoader defaultLoader].allFontWrappers;
    [self.fontTableView reloadData];
    [[ZHYBundleLoader defaultLoader] synchonizePlist];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.fontWrappers.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if (row >= self.fontWrappers.count) {
        return nil;
    }
   
    ZHYFontWrapper *fontWrapper = [self.fontWrappers objectAtIndex:row];
    
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
    
    if ([tableColumn.identifier isEqualToString:@"name"] || [tableColumn.identifier isEqualToString:@"detail"]) {
        ZHYFontInfo *fontInfo = fontWrapper.resourceInfo;
        textLabel.stringValue = ([fontInfo valueForKey:tableColumn.identifier] ? : @"");
    } else if ([tableColumn.identifier isEqualToString:@"descriptor"]) {
        NSFont *font = fontWrapper.font;
        NSString *stringValue = [NSString stringWithFormat:@"%@ %.1f", font.fontName, font.pointSize];
        textLabel.stringValue = stringValue;
    }
        
    return textLabel;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    [self updateSelectedRow];
}

- (void)updateSelectedRow {
    NSInteger selectedIndex = self.fontTableView.selectedRow;
    
    ZHYFontWrapper *colorWrapper = nil;
    if (selectedIndex < self.fontWrappers.count) {
        colorWrapper = [self.fontWrappers objectAtIndex:selectedIndex];
    }
    
    self.selectedFontWrapper = colorWrapper;
}

- (ZHYFontWindowController *)fontWindowController {
    if (!_fontWindowController) {
        _fontWindowController = [[ZHYFontWindowController alloc] initWithWindowNibName:@"ZHYFontWindowController"];
    }
    return _fontWindowController;
}

- (void)setSelectedFontWrapper:(ZHYFontWrapper *)selectedFontWrapper {
    _selectedFontWrapper = selectedFontWrapper;
    
    self.editButton.enabled = (_selectedFontWrapper != nil);
    self.removeButton.enabled = (_selectedFontWrapper != nil);
}

@end
