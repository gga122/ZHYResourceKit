//
//  ZHYBundleInfoCellView.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 13/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleInfoCellView.h"

@interface ZHYBundleInfoCellView () <NSTextFieldDelegate>

@property (nonatomic, strong) NSTextField *textField;
@property (nonatomic, strong) NSButton *addButton;
@property (nonatomic, strong) NSButton *removeButton;

@property (nonatomic, assign) NSTrackingArea *trackingArea;
@property (nonatomic, assign) BOOL mouseEntered;

@end

@implementation ZHYBundleInfoCellView

- (instancetype)initWithFrame:(NSRect)frameRect objectValue:(id)objectValue {
    self = [super initWithFrame:frameRect];
    if (self) {
        NSTextField *textField = [[NSTextField alloc] initWithFrame:NSZeroRect];
        textField.bordered = NO;
        textField.delegate = self;
        [self addSubview:textField];
        _textField = textField;

        NSImage *addImage = [NSImage imageNamed:NSImageNameAddTemplate];
        NSButton *addButton = [NSButton buttonWithImage:addImage target:self action:@selector(addButtonDidClick:)];
        [self addSubview:addButton];
        _addButton = addButton;
        
        NSImage *removeImage = [NSImage imageNamed:NSImageNameRemoveTemplate];
        NSButton *removeButton = [NSButton buttonWithImage:removeImage target:self action:@selector(removeButtonDidClick:)];
        [self addSubview:removeButton];
        _removeButton = removeButton;
        
        [self layoutSubViewsWithFrame:frameRect];
        _objectValue = [objectValue copy];
    }
    
    return self;
}

- (void)updateTrackingAreas {
    if (self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    
    NSTrackingAreaOptions options = NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways | NSTrackingInVisibleRect;
    NSTrackingArea *trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:options owner:self userInfo:nil];
    [self addTrackingArea:trackingArea];
    self.trackingArea = trackingArea;
    
    [super updateTrackingAreas];
}

- (void)mouseEntered:(NSEvent *)event {
    self.addButton.hidden = NO;
    self.removeButton.hidden = NO;
}

- (void)mouseExited:(NSEvent *)event {
    self.addButton.hidden = YES;
    self.removeButton.hidden = YES;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];

    [self layoutSubViewsWithFrame:frame];
}

- (void)layoutSubViewsWithFrame:(NSRect)frame {
    CGFloat height = NSHeight(frame);
    CGFloat width = NSWidth(frame);
    
    CGFloat maxX = width - height;
    self.removeButton.frame = NSMakeRect(maxX, 0, height, height);
    
    maxX = maxX - height;
    self.addButton.frame = NSMakeRect(maxX, 0, height, height);
    
    self.textField.frame = NSMakeRect(0, 0, maxX, height);
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    return [self initWithFrame:frameRect objectValue:nil];
}

- (void)prepareForReuse {
    self.textField.stringValue = @"";
        
    [super prepareForReuse];
}


- (void)addButtonDidClick:(id)sender {
    id<ZHYBundleInfoCellViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bundleInfoCellViewClickedAddRow:)]) {
        [delegate bundleInfoCellViewClickedAddRow:self];
    }
}

- (void)removeButtonDidClick:(id)sender {
    id<ZHYBundleInfoCellViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bundleInfoCellViewClickedRemoveRow:)]) {
        [delegate bundleInfoCellViewClickedRemoveRow:self];
    }
}

- (void)controlTextDidBeginEditing:(NSNotification *)notification {
    if (notification.object != self.textField) {
        return;
    }
    
    id<ZHYBundleInfoCellViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bundleInfoCellView:didBeginEditing:)]) {
        [delegate bundleInfoCellView:self didBeginEditing:[notification.object stringValue]];
    }
}

- (void)controlTextDidEndEditing:(NSNotification *)notification {
    if (notification.object != self.textField) {
        return;
    }
    
    id<ZHYBundleInfoCellViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bundleInfoCellView:didEndEditing:)]) {
        [delegate bundleInfoCellView:self didEndEditing:[notification.object stringValue]];
    }
}

- (void)controlTextDidChange:(NSNotification *)notification {
    if (notification.object != self.textField) {
        return;
    }
    
    id<ZHYBundleInfoCellViewDelegate> delegate = self.delegate;
    if ([delegate respondsToSelector:@selector(bundleInfoCellView:didChangeText:)]) {
        [delegate bundleInfoCellView:self didChangeText:[notification.object stringValue]];
    }
}

#pragma mark - Public Property

- (void)setStringValue:(NSString *)stringValue {
    self.textField.stringValue = stringValue;
}

- (NSString *)stringValue {
    return self.textField.stringValue;
}

- (void)setEditable:(BOOL)editable {
    self.textField.editable = editable;
}

- (BOOL)editable {
    return self.textField.editable;
}

@end
