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
    if (item == nil) {
        return NO;
    }
    
    return ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]);
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if (item == nil) {
        return 1;
    } else {
        if ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]) {
            return [item count];
        }
        
        return 1;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    if (item == nil) {
        return NO;
    }
    
    return ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]]);
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if (item == nil) {
        return self.contents.allKeys;
    } else {
        return [item objectAtIndex:index];
    }
}

- (NSTableRowView *)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item {
    NSTableRowView *rowView = [outlineView makeViewWithIdentifier:@"rowView" owner:self];
    if (rowView == nil) {
        rowView = [[NSTableRowView alloc] initWithFrame:NSZeroRect];
        rowView.identifier = @"rowView";
    }
    
    return rowView;
}

- (nullable NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(nullable NSTableColumn *)tableColumn item:(id)item {   
    static NSString * const kTextFieldIdentifier = @"textField";
    static NSString * const kPopUpButtonIdentifier = @"popUpButton";
    
    if ([tableColumn.identifier isEqualToString:@"value"]) {
        NSTextField *valueTextField = [outlineView makeViewWithIdentifier:kTextFieldIdentifier owner:self];
        if (valueTextField == nil) {
            valueTextField = [[NSTextField alloc] initWithFrame:NSZeroRect];
            valueTextField.bordered = NO;
            valueTextField.identifier = kTextFieldIdentifier;
        }
        
        valueTextField.stringValue = [self.contents objectForKey:item];
        return valueTextField;
    } else if ([tableColumn.identifier isEqualToString:@"type"]) {
        NSPopUpButton *typePopupButton = [outlineView makeViewWithIdentifier:kPopUpButtonIdentifier owner:self];
        if (typePopupButton == nil) {
            typePopupButton = [[NSPopUpButton alloc] initWithFrame:NSZeroRect];
            typePopupButton.bezelStyle = NSBezelStyleRoundRect;
            typePopupButton.identifier = kPopUpButtonIdentifier;
            typePopupButton.bordered = NO;
        }
        
        return typePopupButton;
    } else if ([tableColumn.identifier isEqualToString:@"key"]) {
        NSTextField *keyTextField = [outlineView makeViewWithIdentifier:@"key" owner:self];
        if (keyTextField == nil) {
            keyTextField = [[NSTextField alloc] initWithFrame:NSZeroRect];
            keyTextField.bordered = NO;
            keyTextField.identifier = @"key";
        }
        
        keyTextField.stringValue = item;
        return keyTextField;
    }
    
    return nil;
}

@end
