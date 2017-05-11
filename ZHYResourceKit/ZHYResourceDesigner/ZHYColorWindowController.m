//
//  ZHYColorWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "NSColor+Hex.h"
#import "ZHYColorWindowController.h"

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

@interface ZHYColorWindowController () <NSTableViewDelegate, NSTableViewDataSource, NSControlTextEditingDelegate>

@property (weak) IBOutlet NSTableView *colorTableView;

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *colorTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSColorWell *colorWell;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSString *> *attribute;

@end

@implementation ZHYColorWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    if (self.attributes.count > 0) {
        [self.colorTableView selectRowIndexes:[NSIndexSet indexSetWithIndex:0] byExtendingSelection:YES];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.colorTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.detailTextField];
}

- (void)dealloc {
    if (self.windowLoaded) {
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
    return self.attributes.count;
}

- (nullable NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    static NSString * const textIdentifier = @"textIdentifier";
    static NSString * const colorIdentifier = @"colorIdentifier";
    
    NSDictionary<NSString *, NSString *> *config = [self.attributes objectAtIndex:row];
    
    if ([tableColumn.title isEqualToString:@"name"] || [tableColumn.title isEqualToString:@"detail"]) {
        NSTextField *textField = [tableView makeViewWithIdentifier:textIdentifier owner:self];
        if (!textField) {
            textField = [[NSTextField alloc] initWithFrame:NSZeroRect];
            textField.bordered = NO;
            textField.editable = NO;
            textField.selectable = NO;
            textField.drawsBackground = NO;
        }
        
        textField.stringValue = [config objectForKey:tableColumn.title] ? : @"";
        return textField;
    } else if ([tableColumn.title isEqualToString:@"color"]) {
        ZHYColorView *colorView = [tableView makeViewWithIdentifier:colorIdentifier owner:self];
        if (!colorView) {
            colorView = [[ZHYColorView alloc] initWithFrame:NSZeroRect];
        }
        
        NSString *hex = [config objectForKey:tableColumn.title];
        NSColor *color = [NSColor colorWithHexARGB:hex];
        if (!color) {
            color = [NSColor whiteColor];
        }
        colorView.color = color;
        
        return colorView;
    }
    
    return nil;
}

#pragma mark - NSTableView Delegate


#pragma mark - NSTableView Notification

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    if (notification.object == self.colorTableView) {
        NSInteger selectedRow = self.colorTableView.selectedRow;
        
        NSMutableDictionary<NSString *, NSString *> *config = [self.attributes objectAtIndex:selectedRow];
        self.attribute = config;
    }
}

#pragma mark - Public Property

- (void)setAttributes:(NSArray<NSMutableDictionary<NSString *,NSString *> *> *)attributes {
    if (_attributes != attributes) {
        _attributes = attributes;
        
        [self.colorTableView reloadData];
    }
}

#pragma mark - Private Property

- (void)setAttribute:(NSMutableDictionary<NSString *,NSString *> *)attribute {
    if (_attribute != attribute) {
        _attribute = attribute;
        
        self.nameTextField.stringValue = [_attribute objectForKey:@"name"] ? : @"";
        self.colorTextField.stringValue = [_attribute objectForKey:@"color"] ? : @"";
        self.detailTextField.stringValue = [_attribute objectForKey:@"detail"] ? : @"";
    }
}

@end
