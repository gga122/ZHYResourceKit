//
//  ZHYBundleWindowController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 27/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleWindowController.h"

static NSString * const kZHYBundleInfoToolbarItemIdentifier = @"ZHYBundleInfoToolbarItemIdentifier";

@interface ZHYBundleWindowController () <NSToolbarDelegate>

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSToolbarItem *> *toolbarItems;

@end

@implementation ZHYBundleWindowController

- (instancetype)initWithResourceBundle:(ZHYResourceBundle *)resourceBundle {
    self = [super initWithWindowNibName:@"ZHYBundleWindowController"];
    if (self) {
        _resourceBundle = resourceBundle;
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _toolbarItems = [NSMutableDictionary dictionary];
    
    NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbarIdentifier"];
    
    NSToolbarItem *infoItem = [[NSToolbarItem alloc] initWithItemIdentifier:kZHYBundleInfoToolbarItemIdentifier];
    infoItem.label = @"Info";
    infoItem.paletteLabel = @"Info";
    infoItem.target = self;
    infoItem.action = @selector(toolbarItemDidClick:);
    
    [self.toolbarItems setObject:infoItem forKey:kZHYBundleInfoToolbarItemIdentifier];
    
    
    toolbar.delegate = self;
    
    self.window.toolbar = toolbar;
}

- (void)windowDidLoad {
    [super windowDidLoad];
}

- (void)toolbarItemDidClick:(id)sender {
    
}

- (nullable NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    return [self.toolbarItems objectForKey:itemIdentifier];
}

@end
