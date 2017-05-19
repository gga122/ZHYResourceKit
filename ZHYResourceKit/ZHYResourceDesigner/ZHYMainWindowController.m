//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYMainWindowController.h"

#import "ZHYColorWindowController.h"
#import "ZHYColorTableRowView.h"

@interface ZHYMainWindowController () <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, strong) NSOpenPanel *openPanel;

@property (weak) IBOutlet NSOutlineView *resourceContentView;

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<NSMutableDictionary *> *> *resourceConfigurations;

@property (weak) IBOutlet NSTextField *pathLabel;

@property (nonatomic, strong) ZHYColorWindowController *colorWindowController;

@property (nonatomic, strong) NSArray<NSArray<ZHYResourceWrapper *> *> *resources;

@end

@implementation ZHYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark - Actions

- (IBAction)bundleButtonDidClick:(id)sender {
    NSInteger response = [self.openPanel runModal];
    if (response == NSFileHandlingPanelOKButton) {
        self.pathLabel.stringValue = self.openPanel.URL.absoluteString ? : @"";
        self.bundle = [NSBundle bundleWithURL:self.openPanel.URL];
    }
}

#pragma mark - Notifications

- (IBAction)resourceContentViewDidDoubleClick:(id)sender {
    NSOutlineView *outlineView = sender;
    NSInteger selectedRow = outlineView.selectedRow;
    
    id item = [outlineView itemAtRow:selectedRow];
    if (!item) {
        return;
    }
    
    if ([item isKindOfClass:[ZHYColorWrapper class]]) {
        [self.window beginSheet:self.colorWindowController.window completionHandler:^(NSModalResponse returnCode) {
            
        }];
//        [self.colorWindowController.window makeKeyAndOrderFront:nil];
        self.colorWindowController.colorWrapper = item;
    }
}

#pragma mark - NSOutlineView DataSource

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item) {
        if ([item isKindOfClass:[NSArray class]]) {
            NSArray *items = item;
            return items.count;
        } else {
            return 0;
        }
    } else {
        return self.resources.count;
    }
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(nullable id)item {
    if (item) {
        if ([item isKindOfClass:[NSArray class]]) {
            NSArray *items = item;
            return [items objectAtIndex:index];
        } else {
            return nil;
        }
    } else {
        return [self.resources objectAtIndex:index];
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isKindOfClass:[NSArray class]];
}

- (NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item {
    if ([item isKindOfClass:[NSArray class]]) {
        static NSString * const kZHYResourceGroupIdentifier = @"kZHYResourceGroupIdentifier";
        
        NSTableRowView *groupView = [outlineView makeViewWithIdentifier:kZHYResourceGroupIdentifier owner:self];
        if (!groupView) {
            groupView = [[NSTableRowView alloc] initWithFrame:NSZeroRect];
        }
        
        groupView.backgroundColor = [NSColor redColor];
        
        return groupView;
    } else {
        static NSString * const kZHYColorChildIdentifier = @"kZHYColorChildIdentifier";
        if ([item isKindOfClass:[ZHYColorWrapper class]]) {
            ZHYColorTableRowView *childView = [outlineView makeViewWithIdentifier:kZHYColorChildIdentifier owner:self];
            if (!childView) {
                childView = [[ZHYColorTableRowView alloc] initWithFrame:NSZeroRect];
            }
            
            childView.colorWrapper = item;
            return childView;
        }
        return nil;
    }
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    return nil;
}

#pragma mark - Private Methods

- (void)saveConfigurations {
    [[ZHYBundleLoader defaultLoader] synchonizePlist];
}

- (void)updateResourcesAndReload {
    NSMutableArray<NSArray *> *resources = [NSMutableArray array];
    
    NSArray<ZHYColorWrapper *> *allColorWrappers = [ZHYBundleLoader defaultLoader].allColorWrappers;
    if (allColorWrappers) {
        [resources addObject:allColorWrappers];
    }
    
    NSArray<ZHYFontWrapper *> *allFontWrappers = [ZHYBundleLoader defaultLoader].allFontWrappers;
    if (allFontWrappers) {
        [resources addObject:allFontWrappers];
    }
    
    NSArray<ZHYImageWrapper *> *allImageWrappers = [ZHYBundleLoader defaultLoader].allImageWrappers;
    if (allImageWrappers) {
        [resources addObject:allImageWrappers];
    }
    
    self.resources = resources;
    
    [self.resourceContentView reloadData];
}

#pragma mark - Private Property

- (void)setBundle:(NSBundle *)bundle {
    if (_bundle != bundle) {
        _bundle = bundle;
        
        [[ZHYBundleLoader defaultLoader] loadBundle:_bundle];
    
        [self updateResourcesAndReload];
    }
}

- (NSOpenPanel *)openPanel {
    if (!_openPanel) {
        _openPanel = [NSOpenPanel openPanel];
        _openPanel.allowedFileTypes = @[@"bundle"];
        _openPanel.allowsMultipleSelection = NO;
    }
    
    return _openPanel;
}

- (ZHYColorWindowController *)colorWindowController {
    if (!_colorWindowController) {
        _colorWindowController = [[ZHYColorWindowController alloc] initWithWindowNibName:@"ZHYColorWindowController"];
    }
    return _colorWindowController;
}

@end
