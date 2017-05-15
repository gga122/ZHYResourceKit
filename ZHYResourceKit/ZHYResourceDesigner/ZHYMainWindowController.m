//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYMainWindowController.h"

#import "ZHYImageWindowController.h"
#import "ZHYFontWindowController.h"
#import "ZHYColorWindowController.h"

@interface ZHYMainWindowController ()

@property (nonatomic, strong) NSOpenPanel *openPanel;

@property (nonatomic, strong) ZHYImageWindowController *imageWindowController;
@property (nonatomic, strong) ZHYFontWindowController *fontWindowController;
@property (nonatomic, strong) ZHYColorWindowController *colorWindowController;

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZHYResourceStruct.descriptor" ofType:@"plist"];
    if (!path) {
        NSError *error = [NSError errorWithDomain:@"ZHYResourceKitForDesigner" code:26 userInfo:@{@"message": @"Invalid bundle structure"}];
        [NSAlert alertWithError:error];
        return;
    }
    
    self.resourceConfigurations = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

- (IBAction)imageButtonDidClick:(id)sender {
    self.imageWindowController.bundle = self.bundle;
    [self.imageWindowController.window makeKeyAndOrderFront:nil];
}

- (IBAction)colorButtonDidClick:(id)sender {
    [self.colorWindowController.window makeKeyAndOrderFront:nil];
    
    NSArray *attributes = [self.resourceConfigurations objectForKey:@"colorResource"];
    self.colorWindowController.attributes = attributes;
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
    } else if (self.colorWindowController.windowLoaded && notify.object == self.colorWindowController.window) {
        [self saveConfigurations];
    }
}

#pragma mark - Private Methods

- (void)saveConfigurations {
    if (self.bundle && self.resourceConfigurations) {
        NSString *path = [self.bundle.resourcePath stringByAppendingPathComponent:@"ZHYResourceStruct.descriptor.plist"];
        [self.resourceConfigurations writeToFile:path atomically:YES];
    }
}

#pragma mark - Private Property

- (NSOpenPanel *)openPanel {
    if (!_openPanel) {
        _openPanel = [NSOpenPanel openPanel];
        _openPanel.allowedFileTypes= @[@"bundle"];
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

- (ZHYColorWindowController *)colorWindowController {
    if (!_colorWindowController) {
        _colorWindowController = [[ZHYColorWindowController alloc] initWithWindowNibName:@"ZHYColorWindowController"];
    }
    
    return _colorWindowController;
}

@end
