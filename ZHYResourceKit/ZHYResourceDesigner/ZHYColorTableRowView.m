//
//  ZHYColorTableRowView.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 19/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorTableRowView.h"

@interface ZHYColorView : NSView

@property (nonatomic, copy) NSColor *backgroundColor;

@end

@implementation ZHYColorView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.backgroundColor) {
        [self.backgroundColor set];
    } else {
        [[NSColor whiteColor] set];
    }
    
    NSRectFill(dirtyRect);
}

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    if (_backgroundColor != backgroundColor) {
        _backgroundColor = [backgroundColor copy];
        
        self.needsDisplay = YES;
    }
}

@end

@interface ZHYColorTableRowView ()

@property (nonatomic, strong) NSTextField *nameLabel;
@property (nonatomic, strong) NSTextField *hexLabel;
@property (nonatomic, strong) ZHYColorView *colorView;
@property (nonatomic, strong) NSTextField *detailLabel;

@end

@implementation ZHYColorTableRowView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.hexLabel];
        [self addSubview:self.colorView];
        [self addSubview:self.detailLabel];
    
        [self layoutSubViewsWithFrame:frameRect];
    }
    
    return self;
}

- (void)layoutSubViewsWithFrame:(NSRect)frame {
    CGFloat totalWidth = NSWidth(frame);
    CGFloat totalHeight = NSHeight(frame);
    
    CGFloat offsetX = 0;
    
    NSSize nameSize = self.nameLabel.attributedStringValue.size;
    if (nameSize.width >= totalWidth) {
        NSRect nameFrame = NSMakeRect(offsetX, 0, totalWidth, totalHeight);
        self.nameLabel.frame = nameFrame;
        return;
    }
    CGFloat nameWidth = 60;
    NSRect nameFrame = NSMakeRect(offsetX, 0, nameWidth, totalHeight);
    offsetX += nameWidth;
    totalWidth -= nameWidth;
    self.nameLabel.frame = nameFrame;
    
    NSSize hexSize = self.hexLabel.attributedStringValue.size;
    if (hexSize.width >= totalWidth) {
        NSRect hexFrame = NSMakeRect(offsetX, 0, totalWidth, NSHeight(frame));
        self.hexLabel.frame = hexFrame;
        return;
    }
    CGFloat hexWidth = 80;
    NSRect hexFrame = NSMakeRect(offsetX, 0, hexWidth, NSHeight(frame));
    offsetX += hexWidth;
    totalWidth -= hexWidth;
    self.hexLabel.frame = hexFrame;
    
    CGFloat colorWidth = 40;
    if (colorWidth >= totalWidth) {
        NSRect colorFrame = NSMakeRect(offsetX, 0, totalWidth, NSHeight(frame));
        self.colorView.frame = colorFrame;
        return;
    }
    NSRect colorFrame = NSMakeRect(offsetX, 0, colorWidth, NSHeight(frame));
    offsetX += colorWidth;
    totalWidth -= colorWidth;
    self.colorView.frame = colorFrame;
    
    NSRect detailFrame = NSMakeRect(offsetX, 0, totalWidth, NSHeight(frame));
    self.detailLabel.frame = detailFrame;
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    
    [self layoutSubViewsWithFrame:frame];
}

- (void)setColorWrapper:(ZHYColorWrapper *)colorWrapper {
    if (_colorWrapper != colorWrapper) {
        _colorWrapper = colorWrapper;
        
        self.colorView.backgroundColor = _colorWrapper.color;
        
        ZHYColorInfo *info = _colorWrapper.resourceInfo;
        self.nameLabel.stringValue = (info.name ? : @"");
        self.hexLabel.stringValue = (info.hex ? : @"");
        self.detailLabel.stringValue = (info.detail ? : @"");
        
        [self layoutSubViewsWithFrame:self.frame];
    }
}

- (NSTextField *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _nameLabel.selectable = NO;
        _nameLabel.editable = NO;
        _nameLabel.bordered = NO;
        _nameLabel.drawsBackground = NO;
    }
    
    return _nameLabel;
}

- (NSTextField *)hexLabel {
    if (!_hexLabel) {
        _hexLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _hexLabel.selectable = NO;
        _hexLabel.editable = NO;
        _hexLabel.bordered = NO;
        _hexLabel.drawsBackground = NO;
    }
    
    return _hexLabel;
}

- (ZHYColorView *)colorView {
    if (!_colorView) {
        _colorView = [[ZHYColorView alloc] initWithFrame:NSZeroRect];
    }
    
    return _colorView;
}

- (NSTextField *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _detailLabel.selectable = NO;
        _detailLabel.editable = NO;
        _detailLabel.bordered = NO;
        _detailLabel.drawsBackground = NO;
    }
    
    return _detailLabel;
}

@end
