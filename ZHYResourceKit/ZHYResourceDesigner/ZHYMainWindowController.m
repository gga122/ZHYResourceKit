//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYMainWindowController.h"

#import "ZHYColorListWindowController.h"
#import "ZHYFontListWindowController.h"
#import "ZHYFontWindowController.h"
#import "ZHYFontTableRowView.h"

#import "ZHYImageWindowController.h"

@interface ZHYMainWindowController () <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (nonatomic, strong) NSOpenPanel *openPanel;

@property (nonatomic, strong) NSBundle *bundle;

@property (weak) IBOutlet NSTextField *pathLabel;

@property (nonatomic, strong) ZHYColorListWindowController *colorListWindowController;
@property (nonatomic, strong) ZHYFontListWindowController *fontListWindowController;

@property (nonatomic, strong) ZHYFontWindowController *fontWindowController;

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

- (IBAction)colorMenuItemDidClick:(id)sender {
    if (!self.bundle) {
        return;
    }
    
    [self.colorListWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)fontMenuItemDidClick:(id)sender {
    if (!self.bundle) {
        return;
    }
    
    [self.fontListWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)imageMenuItemDidClick:(id)sender {
    if (!self.bundle) {
        return;
    }
}

#pragma mark - Private Methods

- (void)saveConfigurations {
    [[ZHYBundleLoader defaultLoader] synchonizePlist];
}

#pragma mark - Private Property

- (void)setBundle:(NSBundle *)bundle {
    if (_bundle != bundle) {
        _bundle = bundle;
        
        [[ZHYBundleLoader defaultLoader] loadBundle:_bundle];
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

- (ZHYColorListWindowController *)colorListWindowController {
    if (!_colorListWindowController) {
        _colorListWindowController = [[ZHYColorListWindowController alloc] initWithWindowNibName:@"ZHYColorListWindowController"];
    }
    return _colorListWindowController;
}

- (ZHYFontListWindowController *)fontListWindowController {
    if (!_fontListWindowController) {
        _fontListWindowController = [[ZHYFontListWindowController alloc] initWithWindowNibName:@"ZHYFontListWindowController"];
    }
    return _fontListWindowController;
}

- (ZHYFontWindowController *)fontWindowController {
    if (!_fontWindowController) {
        _fontWindowController = [[ZHYFontWindowController alloc] initWithWindowNibName:@"ZHYFontWindowController"];
    }
    return _fontWindowController;
}

@end
