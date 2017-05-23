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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.colorTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.detailTextField];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetStates {
    self.nameTextField.stringValue = @"";
    self.colorTextField.stringValue = @"";
    self.detailTextField.stringValue = @"";
    self.colorInfo = nil;
}

- (void)controlTextDidChange:(NSNotification *)obj {
    if (obj.object == self.nameTextField) {
        self.colorInfo.name = self.nameTextField.stringValue;
    } else if (obj.object == self.colorTextField) {
        self.colorInfo.hex = self.colorTextField.stringValue;
    } else if (obj.object == self.detailTextField) {
        self.colorInfo.detail = self.detailTextField.stringValue;
    }
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
    
        self.colorWell.color = _colorWrapper.color;
        
        ZHYColorInfo *colorInfo = _colorWrapper.resourceInfo;
        
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

- (ZHYColorInfo *)colorInfo {
    if (!_colorInfo) {
        _colorInfo = [[ZHYColorInfo alloc] initWithColorHex:@"000000" forName:@""];
    }
    
    return _colorInfo;
}

@end
