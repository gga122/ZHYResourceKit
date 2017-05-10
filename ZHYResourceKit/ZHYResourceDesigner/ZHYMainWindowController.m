//
//  ZHYMainWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYMainWindowController.h"
#import "ZHYColorWindowController.h"

@interface ZHYMainWindowController ()

@property (nonatomic, strong) ZHYColorWindowController *colorWindowController;

@property (nonatomic, strong) NSDictionary *resourceConfigurations;

@end

@implementation ZHYMainWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)bundleButtonDidClick:(id)sender {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZHYResourceStruct.descriptor" ofType:@"plist"];
    
    self.resourceConfigurations = [NSMutableDictionary dictionaryWithContentsOfFile:path];
}

- (IBAction)imageButtonDidClick:(id)sender {
    
}

- (IBAction)colorButtonDidClick:(id)sender {
    [self.colorWindowController.window makeKeyAndOrderFront:nil];
    
    NSArray *attributes = [self.resourceConfigurations objectForKey:@"colorResource"];
    self.colorWindowController.attributes = attributes;
}

- (IBAction)fontButtonDidClick:(id)sender {
    
}

#pragma mark - Private Property

- (ZHYColorWindowController *)colorWindowController {
    if (!_colorWindowController) {
        _colorWindowController = [[ZHYColorWindowController alloc] initWithWindowNibName:@"ZHYColorWindowController"];
    }
    
    return _colorWindowController;
}

@end
