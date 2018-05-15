//
//  ZHYBundleInfoViewController.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 2/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYBundleInfoViewController.h"
#import "ZHYBundleInfoCellView.h"
#import "ZHYResourceBundleDefines.h"

static NSString * const kZHYBundleInfoTypeBoolean = @"Boolean";
static NSString * const kZHYBundleInfoTypeData = @"Data";
static NSString * const kZHYBundleInfoTypeDate = @"Date";
static NSString * const kZHYBundleInfoTypeNumber = @"Number";
static NSString * const kZHYBundleInfoTypeString = @"String";

static NSString * const kZHYBundleInfoTypeArray = @"Array";
static NSString * const kZHYBundleInfoTypeDictionary = @"Dictionary";

@interface ZHYBundleInfoViewController () <NSOutlineViewDelegate, NSOutlineViewDataSource, NSMenuDelegate, ZHYBundleInfoCellViewDelegate>

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
        return YES;
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
        return YES;
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
        
        rowView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;
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
        
        valueTextField.editable = canEditResourceBundleInfoValue(item);
        valueTextField.stringValue = [self.contents objectForKey:item];
        return valueTextField;
    } else if ([tableColumn.identifier isEqualToString:@"type"]) {
        NSPopUpButton *typePopupButton = [outlineView makeViewWithIdentifier:kPopUpButtonIdentifier owner:self];
        if (typePopupButton == nil) {
            typePopupButton = [[NSPopUpButton alloc] initWithFrame:NSZeroRect pullsDown:NO];
            
            [typePopupButton addItemsWithTitles:[[self class] basicTypes]];
            [typePopupButton.menu addItem:[NSMenuItem separatorItem]];
            [typePopupButton addItemsWithTitles:[[self class] containerTypes]];
            
            typePopupButton.bezelStyle = NSBezelStyleRoundRect;
            typePopupButton.identifier = kPopUpButtonIdentifier;
            typePopupButton.bordered = NO;
        }
        
        return typePopupButton;
    } else if ([tableColumn.identifier isEqualToString:@"key"]) {
        ZHYBundleInfoCellView *cellView = [outlineView makeViewWithIdentifier:@"key" owner:self];
        if (cellView == nil) {
            cellView = [[ZHYBundleInfoCellView alloc] initWithFrame:NSZeroRect];
            cellView.identifier = @"key";
            cellView.delegate = self;
        }
        
        cellView.stringValue = item;
        cellView.editable = canEditResourceBundleInfoKey(item);
        return cellView;
    }
    
    return nil;
}

#pragma mark - ZHYBundleInfoCellViewDelegate

- (void)bundleInfoCellViewClickedAddRow:(ZHYBundleInfoCellView *)cellView {
    [self.contents setObject:@"" forKey:@""];
    
    [self.bundleInfoOutlineView reloadData];
}

- (void)bundleInfoCellViewClickedRemoveRow:(ZHYBundleInfoCellView *)cellView {
    
}

#pragma mark - Private Methods

+ (NSArray<NSString *> *)basicTypes {
    static NSArray<NSString *> *basicTypes = nil;
    if (basicTypes == nil) {
        basicTypes = @[kZHYBundleInfoTypeBoolean, kZHYBundleInfoTypeData, kZHYBundleInfoTypeDate, kZHYBundleInfoTypeNumber, kZHYBundleInfoTypeString];
    }
    
    return basicTypes;
}

+ (NSString *)typeForClass:(Class)cls {
    NSParameterAssert(cls != nil);
    
    return nil;
}

+ (NSArray<NSString *> *)containerTypes {
    static NSArray<NSString *> *containerTypes = nil;
    if (containerTypes == nil) {
        containerTypes = @[kZHYBundleInfoTypeArray, kZHYBundleInfoTypeDictionary];
    }
    
    return containerTypes;
}

@end
