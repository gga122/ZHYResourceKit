//
//  ZHYColorWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 19/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorWindowController.h"
#import "NSColor+ZHYHex.h"

#import "ZHYBundleLoader.h"

@interface ZHYColorWindowController ()

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@property (nonatomic, copy) ZHYColorInfo *colorInfo;

@end

@implementation ZHYColorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)resetStates {
    self.nameTextField.stringValue = @"";
    self.colorTextField.stringValue = @"";
    self.detailTextField.stringValue = @"";
    self.colorInfo = nil;
}

- (IBAction)okButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        ZHYColorWrapper *currentColorWrapper = self.currentColorWrapper;
        if (currentColorWrapper) {
            ZHYColorWrapper *oldColorWrapper = self.colorWrapper;
            if (oldColorWrapper) {
                [[ZHYBundleLoader defaultLoader] removeResourceInfo:oldColorWrapper.resourceInfo inClassification:kZHYResourceKeyTypeColor];
            }
            
            [[ZHYBundleLoader defaultLoader] addResourceInfo:currentColorWrapper.resourceInfo inClassification:kZHYResourceKeyTypeColor];
        }
        
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
        [self resetStates];
    }
}

- (IBAction)cancelButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
        [self resetStates];
    }
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
    self.colorInfo.hex = hex;
}

- (void)setColorWrapper:(ZHYColorWrapper *)colorWrapper {
    if (_colorWrapper != colorWrapper) {
        _colorWrapper = colorWrapper;
    
        self.colorWell.color = colorWrapper.color;
        
        ZHYColorInfo *colorInfo = colorWrapper.resourceInfo;
        
        self.nameTextField.stringValue = (colorInfo.name ? : @"");
        self.colorTextField.stringValue = (colorInfo.hex ? : @"");
        self.detailTextField.stringValue = (colorInfo.detail ? : @"");
        
        self.colorInfo = colorInfo;
    }
}

- (ZHYColorWrapper *)currentColorWrapper {
    ZHYColorWrapper *colorWrapper = [[ZHYColorWrapper alloc] initWithResourceInfo:self.colorInfo];
    if (!colorWrapper.color) {
        return nil;
    }

    return colorWrapper;
}

@end
