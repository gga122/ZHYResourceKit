//
//  ZHYFontWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYFontWindowController.h"
#import "ZHYBundleLoader.h"
#import "NSFont+ZHYAttributes.h"

static NSString * const kZHYResouceTestText = @"这是一段测试的文本,For Test only.测试1，2，3，4，5，6，7，8，9，10";

@interface ZHYFontWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *fontTextField;
@property (weak) IBOutlet NSButton *fontPanelButton;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSTextField *testTextLabel;

@property (nonatomic, copy) ZHYFontInfo *fontInfo;

@end

@implementation ZHYFontWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)resetState {
    self.nameTextField.stringValue = @"";
    self.fontTextField.stringValue = @"";
    self.detailTextField.stringValue = @"";
    self.fontInfo = nil;
}

#pragma mark - Actions

- (IBAction)okButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        ZHYFontWrapper *currentFontWrapper = self.currentFontWrapper;
        if (currentFontWrapper) {
            ZHYFontWrapper *oldFontWrapper = self.fontWrapper;
            if (oldFontWrapper) {
                [[ZHYBundleLoader defaultLoader] removeResourceInfo:oldFontWrapper.resourceInfo inClassification:kZHYResourceKeyTypeFont];
            }
            
            [[ZHYBundleLoader defaultLoader] addResourceInfo:currentFontWrapper.resourceInfo inClassification:kZHYResourceKeyTypeFont];
        }
                
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
        [self resetState];
    }
}

- (IBAction)cancelButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
        [self resetState];
    }
}

- (IBAction)fontPanelButtonDidClick:(id)sender {
    [[NSFontManager sharedFontManager] setTarget:self];
    [[NSFontManager sharedFontManager] orderFrontFontPanel:self];
}

- (void)changeFont:(id)sender {
    NSFont *oldFont = self.fontWrapper.font;
    if (!oldFont) {
        oldFont = [NSFont systemFontOfSize:12.0];
    }
    
    NSFont *font = [sender convertFont:oldFont];
    self.fontInfo.descriptor = font.attributes;
}

#pragma mark - Public Property

- (void)setFontWrapper:(ZHYFontWrapper *)fontWrapper {
    if (_fontWrapper != fontWrapper) {
        _fontWrapper = fontWrapper;
        
        ZHYFontInfo *fontInfo = _fontWrapper.resourceInfo;
        
        self.nameTextField.stringValue = (fontInfo.name ? : @"");
        
        self.detailTextField.stringValue = (fontInfo.detail ? : @"");
        
        self.fontInfo = fontInfo;
    }
}

- (ZHYFontWrapper *)currentFontWrapper {
    ZHYFontWrapper *fontWrapper = [[ZHYFontWrapper alloc] initWithResourceInfo:self.fontInfo];
    if (!fontWrapper.font) {
        return nil;
    }
    
    return fontWrapper;
}

@end
