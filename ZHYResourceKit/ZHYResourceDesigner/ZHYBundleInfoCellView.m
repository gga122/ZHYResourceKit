//
//  ZHYBundleInfoCellView.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 13/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleInfoCellView.h"

@interface ZHYBundleInfoCellView ()

@property (nonatomic, strong) NSTextField *textField;
@property (nonatomic, strong) NSPopUpButton *popupButton;
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
        [self addSubview:textField];
        _textField = textField;
        
        NSPopUpButton *popupButton = [[NSPopUpButton alloc] initWithFrame:NSZeroRect];
        popupButton.bezelStyle = NSBezelStyleRoundRect;
        popupButton.bordered = NO;
        [self addSubview:popupButton];
        _popupButton = popupButton;
        
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
    self.mouseEntered = YES;
    
    [self layoutSubViewsWithFrame:self.frame];
}

- (void)mouseExited:(NSEvent *)event {
    self.mouseEntered = YES;
    
    [self layoutSubViewsWithFrame:self.frame];
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];

    [self layoutSubViewsWithFrame:frame];
}

- (void)layoutSubViewsWithFrame:(NSRect)frame {
    CGFloat height = NSHeight(frame);
    CGFloat width = NSWidth(frame);
    
    static CGFloat const kPopupButtonWidth = 20.0;
    
    if (self.mouseEntered) {
        CGFloat maxX = width - height;
        self.removeButton.frame = NSMakeRect(maxX, 0, height, height);

        maxX = maxX - height;
        self.addButton.frame = NSMakeRect(maxX, 0, height, height);
        
        maxX = maxX - kPopupButtonWidth;
        self.popupButton.frame = NSMakeRect(maxX, 0, kPopupButtonWidth, height);
        
        self.textField.frame = NSMakeRect(0, 0, maxX, height);
    } else {
        self.addButton.frame = NSZeroRect;
        self.removeButton.frame = NSZeroRect;
        
        self.popupButton.frame = NSMakeRect(width - kPopupButtonWidth, 0, kPopupButtonWidth, height);
        self.textField.frame = NSMakeRect(0, 0, width - kPopupButtonWidth, height);
    }
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    return [self initWithFrame:frameRect objectValue:nil];
}

- (void)prepareForReuse {
    self.textField.stringValue = @"";
    
    [super prepareForReuse];
}


- (void)addButtonDidClick:(id)sender {
    
}

- (void)removeButtonDidClick:(id)sender {
    
}

@end
