//
//  ZHYImageWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYImageWindowController.h"
#import "ZHYBundleLoader.h"

@interface ZHYImageWindowController ()

@property (weak) IBOutlet NSTextField *nameTextField;
@property (weak) IBOutlet NSTextField *pathTextField;
@property (weak) IBOutlet NSTextField *detailTextField;

@property (weak) IBOutlet NSImageView *imageView;

@property (nonatomic, copy) ZHYImageInfo *imageInfo;

@end

@implementation ZHYImageWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.nameTextField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controlTextDidChange:) name:NSControlTextDidChangeNotification object:self.detailTextField];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetState {
    self.imageWrapper = nil;
}

- (void)controlTextDidChange:(NSNotification *)obj {
    if (obj.object == self.nameTextField) {
        self.imageInfo.name = self.nameTextField.stringValue;
    } else if (obj.object == self.detailTextField) {
        self.imageInfo.detail = self.detailTextField.stringValue;
    }
}

- (IBAction)okButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        ZHYImageWrapper *currentImageWrapper = self.currentImageWrapper;
        if (currentImageWrapper) {
            ZHYImageWrapper *oldImageWrapper = self.imageWrapper;
            if (oldImageWrapper) {
                [[ZHYBundleLoader defaultLoader] removeResourceInfo:oldImageWrapper.resourceInfo inClassification:kZHYResourceKeyTypeImage];
            }
        
            [[ZHYBundleLoader defaultLoader] addResourceInfo:currentImageWrapper.resourceInfo inClassification:kZHYResourceKeyTypeImage];
        }
        
        [self.window.parentWindow endSheet:self.window returnCode:NSModalResponseOK];
        [self resetState];
    }
}

- (IBAction)cancelButtonDidClick:(id)sender {
    if (self.window.isSheet) {
        [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
        [self resetState];
    }
}

- (void)setImageWrapper:(ZHYImageWrapper *)imageWrapper {
    if (_imageWrapper != imageWrapper) {
        
        self.imageView.image = _imageWrapper.image;
        
        ZHYImageInfo *info = _imageWrapper.resourceInfo;
        
        self.nameTextField.stringValue = (info.name ? : @"");
        self.pathTextField.stringValue = (info.path ? : @"");
        self.detailTextField.stringValue = (info.name ? : @"");
        
        self.imageInfo = info;
    }
}

- (ZHYImageWrapper *)currentImageWrapper {
    ZHYImageWrapper *imageWrapper = [[ZHYImageWrapper alloc] initWithResourceInfo:self.imageInfo];
    if (!imageWrapper) {
        return nil;
    }
    
    return imageWrapper;
}

- (ZHYImageInfo *)imageInfo {
    if (!_imageInfo) {
        _imageInfo = [[ZHYImageInfo alloc] initWithPath:@"" forName:@""];
    }
    return _imageInfo;
}

@end
