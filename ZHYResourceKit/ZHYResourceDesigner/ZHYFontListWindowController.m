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

@property (nonatomic, strong) NSArray<ZHYFontWrapper *> *fontWrappers;

@property (nonatomic, strong) ZHYFontWrapper *selectedFontWrapper;

@end

@implementation ZHYFontListWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)addFontButtonDidClick:(id)sender {
    
}

- (IBAction)removeFontButtonDidClick:(id)sender {
    
}

- (IBAction)editFontButtonDidClick:(id)sender {
    
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

@end
