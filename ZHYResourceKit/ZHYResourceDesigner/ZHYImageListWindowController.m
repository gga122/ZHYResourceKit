//
//  ZHYImageListWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 24/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYImageListWindowController.h"
#import "ZHYImageWindowController.h"
#import "ZHYImageSearcher.h"

@interface ZHYImageListWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *imageTableView;

@property (nonatomic, strong) NSArray<ZHYImageWrapper *> *imageWrappers;

@property (nonatomic, strong) ZHYImageInfo *selectedImageWrapper;

@end

@implementation ZHYImageListWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    self.imageWrappers = [ZHYBundleLoader defaultLoader].allImageWrappers;
    [self.imageTableView reloadData];
}

- (IBAction)imageEditButtonDidClick:(id)sender {
    
}

- (IBAction)imageScanButtonDidClick:(id)sender {
    NSBundle *bundle = [ZHYBundleLoader defaultLoader].bundle;
    ZHYImageSearcher *searcher = [[ZHYImageSearcher alloc] initWithBundle:bundle];
    
    NSArray<ZHYImageInfo *> *allImageInfos = searcher.infos;
    for (ZHYImageInfo *aInfo in allImageInfos) {
        [[ZHYBundleLoader defaultLoader] addResourceInfo:aInfo inClassification:kZHYResourceKeyTypeImage];
    }
    
    [self reload];
}

- (void)reload {
    self.imageWrappers = [ZHYBundleLoader defaultLoader].allImageWrappers;
    [self.imageTableView reloadData];
    [[ZHYBundleLoader defaultLoader] synchonizePlist];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSUInteger imageWrapperCount = self.imageWrappers.count;
    if (imageWrapperCount == 0) {
        return imageWrapperCount;
    }
    
    NSUInteger columnCount = tableView.tableColumns.count;
    
    NSInteger numberOfRows = imageWrapperCount / columnCount;
    if (imageWrapperCount % columnCount != 0) {
        numberOfRows += 1;
    }
    
    return numberOfRows;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    static CGFloat const kZHYMaxRowHeight = 200;
    CGFloat tableViewHeight = NSHeight(tableView.frame);
    
    return (tableViewHeight > 2 * kZHYMaxRowHeight ? kZHYMaxRowHeight : tableViewHeight / 2);
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSInteger columnIndex = tableColumn.identifier.integerValue;
    NSInteger index = row * tableView.numberOfColumns + columnIndex;
    if (index >= self.imageWrappers.count) {
        return nil;
    }
    ZHYImageWrapper *imageWrapper = [self.imageWrappers objectAtIndex:index];
    
    static NSString * const kZHYImageIdentifier = @"kZHYImageIdentifier";
    NSImageView *imageView = [tableView makeViewWithIdentifier:kZHYImageIdentifier owner:self];
    if (!imageView) {
        imageView = [[NSImageView alloc] initWithFrame:NSZeroRect];
        imageView.identifier = kZHYImageIdentifier;
        imageView.imageScaling = NSImageScaleProportionallyUpOrDown;
    }
    
    imageView.image = imageWrapper.image;
    return imageView;
}

@end
