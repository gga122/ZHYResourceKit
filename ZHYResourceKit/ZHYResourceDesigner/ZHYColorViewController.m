//
//  ZHYColorViewController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorViewController.h"
#import "ZHYBundleLoader.h"
#import "ZHYColorWrapper.h"

@interface ZHYColorView : NSView

@property (nonatomic, copy) NSColor *color;

@end

@implementation ZHYColorView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    [self.color set];
    NSRectFill(dirtyRect);
}

- (void)setColor:(NSColor *)color {
    if (_color != color) {
        _color = [color copy];
    }
    
    self.needsDisplay = YES;
}

@end

@interface ZHYColorViewController () <NSTableViewDelegate, NSTableViewDataSource, NSControlTextEditingDelegate>

@property (weak) IBOutlet NSTableView *colorTableView;

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@property (nonatomic, strong) NSArray<ZHYColorWrapper *> *allColorWrapper;

@property (nonatomic, strong) ZHYColorWrapper *currentColorWrapper;

@end

@implementation ZHYColorViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.allColorWrapper = [ZHYBundleLoader defaultLoader].allColorWrappers;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.colorTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.detailTextField];
}

- (void)dealloc {
    if (self.viewLoaded) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

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

#pragma mark - Notifications

- (void)controlTextDidChange:(NSNotification *)obj {
    
}

#pragma mark - NSTableView Datasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.allColorWrapper.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    static NSString * const textIdentifier = @"textIdentifier";
    static NSString * const colorIdentifier = @"colorIdentifier";
    
    ZHYColorWrapper *colorWrapper = [self.allColorWrapper objectAtIndex:row];
    
    if ([tableColumn.title isEqualToString:@"name"] || [tableColumn.title isEqualToString:@"detail"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:textIdentifier owner:self];
        if (!textField) {
            textField = [[NSTextField alloc] initWithFrame:NSZeroRect];
            textField.bordered = NO;
            textField.editable = NO;
            textField.selectable = NO;
            textField.drawsBackground = NO;
        }
        
        textField.stringValue = (colorWrapper.name ? : @"");
        return textField;
    } else if ([tableColumn.title isEqualToString:@"color"]) {
        ZHYColorView *colorView = [tableView makeViewWithIdentifier:colorIdentifier owner:self];
        if (!colorView) {
            colorView = [[ZHYColorView alloc] initWithFrame:NSZeroRect];
        }
        colorView.color = colorWrapper.color;
        
        return colorView;
    }
    
    return nil;
}

#pragma mark - NSTableView Delegate


#pragma mark - NSTableView Notification

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (notification.object == self.colorTableView) {
        NSInteger selectedRow = self.colorTableView.selectedRow;
        
        ZHYColorWrapper *colorWrapper = [self.allColorWrapper objectAtIndex:selectedRow];
        self.currentColorWrapper = colorWrapper;
    }
}

#pragma mark - Private Property

- (void)setAllColorWrapper:(NSArray<ZHYColorWrapper *> *)allColorWrapper {
    if (_allColorWrapper != allColorWrapper) {
        _allColorWrapper = allColorWrapper;
        
        [self.colorTableView reloadData];
    }
}

- (void)setCurrentColorWrapper:(ZHYColorWrapper *)currentColorWrapper {
    if (_currentColorWrapper != currentColorWrapper) {
        _currentColorWrapper = currentColorWrapper;
        
        ZHYColorInfo *info = _currentColorWrapper.resourceInfo;
        
        self.nameTextField.stringValue = (info.name ? : @"");
        self.colorTextField.stringValue = (info.hex ? : @"");
        self.colorTextField.stringValue = (info.detail ? : @"");
        
        self.colorWell.color = _currentColorWrapper.color;
    }
}

@end
