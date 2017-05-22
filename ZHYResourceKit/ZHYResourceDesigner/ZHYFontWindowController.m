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

@end

@implementation ZHYFontWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark - Actions

- (IBAction)okButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
    }
}

- (IBAction)cancelButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
    }
}

- (IBAction)fontPanelButtonDidClick:(id)sender {
    [[NSFontManager sharedFontManager] setTarget:self];
    [[NSFontManager sharedFontManager] orderFrontFontPanel:self];
}

- (void)changeFont:(id)sender {

}

#pragma mark - Public Property



#pragma mark - Private Property



@end
