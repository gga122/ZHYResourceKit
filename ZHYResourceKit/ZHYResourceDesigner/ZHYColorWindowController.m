//
//  ZHYColorWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorWindowController.h"

@interface ZHYColorWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *colorTableView;

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *attribute;

@end

@implementation ZHYColorWindowController

#pragma mark - Actions

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

#pragma mark - NSTableView Datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.attributes.count;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
}

@end
