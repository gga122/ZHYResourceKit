//
//  ZHYBundleInfoViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleInfoViewController.h"

@interface ZHYBundleInfoViewController () <NSOutlineViewDelegate, NSOutlineViewDataSource>

@property (weak) IBOutlet NSOutlineView *bundleInfoOutlineView;
@property (nonatomic, strong) NSMutableDictionary *contents;

@end

@implementation ZHYBundleInfoViewController

- (instancetype)initWithContents:(NSDictionary *)contents {
    if (contents == nil) {
        return nil;
    }
    
    self = [super initWithNibName:@"ZHYBundleInfoViewController" bundle:nil];
    if (self) {
        _contents = [NSMutableDictionary dictionaryWithDictionary:contents];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - OutlineView Delegate & DataSource

- (BOOL)outlineView:(NSOutlineView *)outlineView isGroupItem:(id)item {
    return NO;
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return self.contents.count;
    } else {
        return 0;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]);
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        NSArray<NSString *> *allKeys = self.contents.allKeys;
        allKeys = [allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
        
        NSString *key = [allKeys objectAtIndex:index];
        return [item objectForKey:key];
    } else {
        return nil;
    }
}

- (NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item {
    return [[NSTableRowView alloc] initWithFrame:NSZeroRect];
}

- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {   
    static NSString * const kTextFieldIdentifier = @"textField";
    static NSString * const kPopUpButtonIdentifier = @"popUpButton";
    
    NSView *view = nil;
    if ([tableColumn.identifier isEqualToString:@"value"]) {
        view = [outlineView makeViewWithIdentifier:kTextFieldIdentifier owner:self];
        if (view == nil) {
            view = [[NSTextField alloc] initWithFrame:NSZeroRect];
            view.identifier = kTextFieldIdentifier;
        }
    } else if ([tableColumn.identifier isEqualToString:@"type"]) {
        view = [outlineView makeViewWithIdentifier:kPopUpButtonIdentifier owner:self];
        if (view == nil) {
            view = [[NSPopUpButton alloc] initWithFrame:NSZeroRect];
            view.identifier = kPopUpButtonIdentifier;
        }
    } else if ([tableColumn.identifier isEqualToString:@"key"]) {
        
    }
    
    return view;
}

@end
