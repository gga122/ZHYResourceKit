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
@property (nonatomic, strong) NSDictionary *resourceConfigurations;

@property (weak) IBOutlet NSTextField *pathLabel;

@end

@implementation ZHYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)bundleButtonDidClick:(id)sender {
    NSInteger response = [self.openPanel runModal];
    if (response == NSFileHandlingPanelOKButton) {
        self.pathLabel.stringValue = self.openPanel.URL.absoluteString ? : @"";
        self.bundle = [NSBundle bundleWithURL:self.openPanel.URL];
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZHYResourceStruct.descriptor" ofType:@"plist"];
    
    self.resourceConfigurations = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

- (IBAction)imageButtonDidClick:(id)sender {
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
