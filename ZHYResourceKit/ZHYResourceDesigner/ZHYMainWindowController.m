//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYResourceWindowController.h"

#import "ZHYMainWindowController.h"

#import "ZHYImageWindowController.h"
#import "ZHYFontWindowController.h"
#import "ZHYColorViewController.h"

@interface ZHYMainWindowController ()

@property (nonatomic, strong) NSOpenPanel *openPanel;

@property (nonatomic, strong) ZHYImageWindowController *imageWindowController;
@property (nonatomic, strong) ZHYFontWindowController *fontWindowController;

@property (nonatomic, strong) ZHYResourceWindowController *colorWindowController;

@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<NSMutableDictionary *> *> *resourceConfigurations;

@property (weak) IBOutlet NSTextField *pathLabel;

@end

@implementation ZHYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:nil];
}

- (void)dealloc {
    if (self.windowLoaded) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

#pragma mark - Actions

- (IBAction)bundleButtonDidClick:(id)sender {
    NSInteger response = [self.openPanel runModal];
    if (response == NSFileHandlingPanelOKButton) {
        self.pathLabel.stringValue = self.openPanel.URL.absoluteString ? : @"";
        self.bundle = [NSBundle bundleWithURL:self.openPanel.URL];
    }
}

- (IBAction)imageButtonDidClick:(id)sender {
    [self.imageWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)colorButtonDidClick:(id)sender {
    [self.colorWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)fontButtonDidClick:(id)sender {
    [self.fontWindowController.window makeKeyAndOrderFront:nil];
}

#pragma mark - Notifications

- (void)windowWillClose:(NSNotification *)notify {
    if (self.fontWindowController.windowLoaded && notify.object == self.fontWindowController.window) {
        [self saveConfigurations];
    } else if (self.imageWindowController.windowLoaded && notify.object == self.imageWindowController.window) {
        [self saveConfigurations];
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

- (ZHYImageWindowController *)imageWindowController {
    if (!_imageWindowController) {
        _imageWindowController = [[ZHYImageWindowController alloc] initWithWindowNibName:@"ZHYImageWindowController"];
    }
    
    return _imageWindowController;
}

- (ZHYFontWindowController *)fontWindowController {
    if (!_fontWindowController) {
        _fontWindowController = [[ZHYFontWindowController alloc] initWithWindowNibName:@"ZHYFontWindowController"];
    }
    
    return _fontWindowController;
}

- (ZHYResourceWindowController *)colorWindowController {
    if (!_colorWindowController) {
        ZHYColorViewController *colorViewController = [[ZHYColorViewController alloc] init];
        _colorWindowController = [[ZHYResourceWindowController alloc] initWithBusinessViewController:colorViewController];
    }
    
    return _colorWindowController;
}

@end
