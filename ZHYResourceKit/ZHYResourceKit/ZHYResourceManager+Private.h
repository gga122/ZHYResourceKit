//
//  ZHYResourceManager+Private.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 11/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceManager.h"
#import "ZHYResourceCenter.h"

@class ZHYColorWrapper;
@class ZHYImageWrapper;
@class ZHYFontWrapper;

@interface ZHYResourceManager (Private)

@property (nonatomic, strong, readonly) ZHYResourceCenter *currentCenter;

- (void)loadBundle:(NSBundle *)bundle;

@property (nonatomic, copy, readonly) NSArray<ZHYColorWrapper *> *allColorWrappers;
@property (nonatomic, copy, readonly) NSArray<ZHYImageWrapper *> *allImageWrappers;
@property (nonatomic, copy, readonly) NSArray<ZHYFontWrapper *> *allFontWrappers;

@end
