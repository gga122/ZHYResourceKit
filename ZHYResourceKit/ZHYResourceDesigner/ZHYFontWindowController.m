//
//  ZHYFontWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontWindowController.h"

static NSString * const kZHYResouceTestText = @"这是一段测试的文本,For Test only.测试1，2，3，4，5，6，7，8，9，10";

@interface ZHYFontWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *fontTextField;
@property (weak) IBOutlet NSButton *fontPanelButton;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSTextField *testTextLabel;

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *currentFontConfiguration;
@property (nonatomic, copy) NSFont *currentFont;

@end

@implementation ZHYFontWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark - Actions

- (IBAction)fontPanelButtonDidClick:(id)sender {
    [[NSFontManager sharedFontManager] setTarget:self];
    [[NSFontManager sharedFontManager] orderFrontFontPanel:self];
}

- (void)changeFont:(id)sender {
    NSFont *font = self.currentFont;
    if (!font) {
        font = [NSFont systemFontOfSize:12.0];
    }
    
    self.currentFont = [sender convertFont:font];
}

#pragma mark - Public Property

- (void)setFontConfigurations:(NSMutableArray<NSMutableDictionary<NSString *,id> *> *)fontConfigurations {
    if (_fontConfigurations != fontConfigurations) {
        _fontConfigurations = fontConfigurations;
    }
}

#pragma mark - Private Property

- (void)setCurrentFontConfiguration:(NSMutableDictionary<NSString *,id> *)currentFontConfiguration {
    if (_currentFontConfiguration != currentFontConfiguration) {
        _currentFontConfiguration = currentFontConfiguration;
    }
}

- (void)setCurrentFont:(NSFont *)currentFont {
    if (_currentFont != currentFont) {
        _currentFont = [currentFont copy];
        
        if (_currentFont) {
            NSString *fontInfo = [NSString stringWithFormat:@"%@ %.1f", _currentFont.fontName, _currentFont.pointSize];
            self.fontTextField.stringValue = fontInfo;
            
            NSDictionary *attributes = @{NSFontAttributeName: _currentFont};
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:kZHYResouceTestText attributes:attributes];
            self.testTextLabel.attributedStringValue = attributedText;
        } else {
            self.fontTextField.stringValue = @"";
        }
    }
}

@end
