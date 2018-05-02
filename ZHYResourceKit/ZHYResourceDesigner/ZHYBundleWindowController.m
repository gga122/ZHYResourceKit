//
//  ZHYBundleWindowController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 27/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleWindowController.h"
#import "ZHYBundleInfoViewController.h"
#import "ZHYFontViewController.h"
#import "ZHYResourceBundle.h"
#import "ZHYLogger.h"

static NSString * const kZHYBundleInfoToolbarItemIdentifier = @"ZHYBundleInfoToolbarItemIdentifier";
static NSString * const kZHYFontToolbarItemIdentifier = @"ZHYFontToolbarItemIdentifier";

@interface ZHYBundleWindowController () <NSToolbarDelegate>

@property (weak) IBOutlet NSBox *contentBox;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSToolbarItem *> *toolbarItems;

@property (nonatomic, strong) ZHYBundleInfoViewController *bundleInfoViewController;
@property (nonatomic, strong) ZHYFontViewController *fontViewController;

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
    
    NSToolbarItem *fontItem = [[NSToolbarItem alloc] initWithItemIdentifier:kZHYFontToolbarItemIdentifier];
    fontItem.label = @"Font";
    fontItem.paletteLabel = @"Font";
    fontItem.target = self;
    fontItem.action = @selector(toolbarItemDidClick:);
    [self.toolbarItems setObject:fontItem forKey:kZHYFontToolbarItemIdentifier];
    
    toolbar.delegate = self;
    
    self.window.toolbar = toolbar;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.window.toolbar setSelectedItemIdentifier:@"Info"];
}

- (void)toolbarItemDidClick:(id)sender {
    if (![sender isKindOfClass:[NSToolbarItem class]]) {
        ZHYLogError(@"'%@' can not handle '%@' for '%@'.", self, _cmd, sender);
        return;
    }
    
    if ([self.window.toolbar.selectedItemIdentifier isEqualToString:kZHYBundleInfoToolbarItemIdentifier]) {
        self.contentBox.contentView = self.bundleInfoViewController.view;
    } else if ([self.window.toolbar.selectedItemIdentifier isEqualToString:kZHYFontToolbarItemIdentifier]) {
        self.contentBox.contentView = self.fontViewController.view;
    }
    // TODO: Do something after selected
}

- (nullable NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    return [self.toolbarItems objectForKey:itemIdentifier];
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    return self.toolbarItems.allKeys;
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return self.toolbarItems.allKeys;
}

- (NSArray<NSToolbarItemIdentifier> *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
    return self.toolbarItems.allKeys;
}

#pragma mark - Private Property

- (ZHYBundleInfoViewController *)bundleInfoViewController {
    if (_bundleInfoViewController == nil) {
        _bundleInfoViewController = [[ZHYBundleInfoViewController alloc] initWithContents:self.resourceBundle.bundleInfos];
    }
    
    return _bundleInfoViewController;
}

- (ZHYFontViewController *)fontViewController {
    if (_fontViewController == nil) {
        _fontViewController = [[ZHYFontViewController alloc] init];
    }
    
    return _fontViewController;
}

@end
