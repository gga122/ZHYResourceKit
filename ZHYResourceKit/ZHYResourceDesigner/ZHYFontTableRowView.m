//
//  ZHYFontTableRowView.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 22/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontTableRowView.h"

@interface ZHYFontTableRowView ()

@property (nonatomic, strong) NSTextField *nameLabel;
@property (nonatomic, strong) NSTextField *attributesLabel;
@property (nonatomic, strong) NSTextField *effectLabel;
@property (nonatomic, strong) NSTextField *detailLabel;

@end

@implementation ZHYFontTableRowView

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.attributesLabel];
        [self addSubview:self.effectLabel];
        [self addSubview:self.detailLabel];
        
        [self layoutSubViewsWithFrame:frameRect];
    }
    
    return self;
}

- (void)layoutSubViewsWithFrame:(NSRect)frame {
    
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    
    [self layoutSubViewsWithFrame:frame];
}

- (void)setFontWrapper:(ZHYFontWrapper *)fontWrapper {
    if (_fontWrapper != fontWrapper) {
        _fontWrapper = fontWrapper;
        
        ZHYFontInfo *info = _fontWrapper.resourceInfo;
        self.nameLabel.stringValue = (info.name ? : @"");
        
        
        self.detailLabel.stringValue = (info.name ? : @"");
        
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

- (NSTextField *)attributesLabel {
    if (!_attributesLabel) {
        _attributesLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _attributesLabel.selectable = NO;
        _attributesLabel.editable = NO;
        _attributesLabel.bordered = NO;
        _attributesLabel.drawsBackground = NO;
    }
    
    return _attributesLabel;
}

- (NSTextField *)effectLabel {
    if (!_effectLabel) {
        _effectLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
        _effectLabel.selectable = NO;
        _effectLabel.editable =  NO;
        _effectLabel.bordered = NO;
        _effectLabel.drawsBackground = NO;
    }
    
    return _effectLabel;
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
