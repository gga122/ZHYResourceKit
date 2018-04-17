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

- (void)bundleInfoCellViewClickedAddRow:(ZHYBundleInfoCellView *)cellView;
- (void)bundleInfoCellViewClickedRemoveRow:(ZHYBundleInfoCellView *)cellView;

@end

@interface ZHYBundleInfoCellView : NSView

- (instancetype)initWithFrame:(NSRect)frameRect objectValue:(nullable id)objectValue NS_DESIGNATED_INITIALIZER;

@property (nonatomic, copy, nullable) id objectValue;

@property (nonatomic, weak) id<ZHYBundleInfoCellViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
