//
//  ZHYBundleInfoCellView.h
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 13/4/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@class ZHYBundleInfoCellView;

@protocol ZHYBundleInfoCellViewDelegate <NSObject>

@optional

- (void)bundleInfoCellViewClickedAddRow:(ZHYBundleInfoCellView *)cellView;
- (void)bundleInfoCellViewClickedRemoveRow:(ZHYBundleInfoCellView *)cellView;

- (void)bundleInfoCellView:(ZHYBundleInfoCellView *)cellView didBeginEditing:(NSString *)stringValue;
- (void)bundleInfoCellView:(ZHYBundleInfoCellView *)cellView didChangeText:(NSString *)stringValue;
- (void)bundleInfoCellView:(ZHYBundleInfoCellView *)cellView didEndEditing:(NSString *)stringValue;

@end

@interface ZHYBundleInfoCellView : NSView

- (instancetype)initWithFrame:(NSRect)frameRect objectValue:(nullable id)objectValue NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)decoder NS_UNAVAILABLE;

@property (nonatomic, copy, nullable) id objectValue;
@property (nonatomic, copy) NSString *stringValue;

@property (nonatomic, weak) id<ZHYBundleInfoCellViewDelegate> delegate;
@property (nonatomic, assign) BOOL editable;

@end

NS_ASSUME_NONNULL_END
