//
//  ZHYColorWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 19/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorWindowController.h"

@interface ZHYColorWindowController ()

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@end

@implementation ZHYColorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (IBAction)okButtonDidClick:(id)sender {
    
}

- (IBAction)cancelButtonDidClick:(id)sender {
    [self close];
}

- (IBAction)colorDidChange:(id)sender {
    NSColor *color = self.colorWell.color;
    
    static CGFloat const colorMaxValue = 255.0;
    
    CGFloat alpha = round(color.alphaComponent * colorMaxValue);
    CGFloat red = round(color.redComponent * colorMaxValue);
    CGFloat green = round(color.greenComponent * colorMaxValue);
    CGFloat blue = round(color.blueComponent * colorMaxValue);
    
    NSMutableString *hex = [NSMutableString stringWithString:@"#"];
    if (colorMaxValue - alpha > 1.0) {
        [hex appendFormat:@"%2x", (int)alpha];
    }
    [hex appendFormat:@"%02x%02x%02x", (int)red, (int)green, (int)blue];
    
    self.colorTextField.stringValue = [hex uppercaseString];
}

- (void)setColorWrapper:(ZHYColorWrapper *)colorWrapper {
    if (_colorWrapper != colorWrapper) {
        _colorWrapper = [colorWrapper copy];
        
        self.colorWell.color = _colorWrapper.color;
        
        ZHYColorInfo *colorInfo = _colorWrapper.resourceInfo;
        self.nameTextField.stringValue = (colorInfo.name ? : @"");
        self.colorTextField.stringValue = (colorInfo.hex ? : @"");
        self.detailTextField.stringValue = (colorInfo.detail ? : @"");
    }
}


@end
