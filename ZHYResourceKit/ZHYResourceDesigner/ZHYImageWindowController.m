//
//  ZHYImageWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYImageWindowController.h"
#import "ZHYImageSearcher.h"

@interface ZHYImageWindowController ()

@property (nonatomic, strong) ZHYImageSearcher *imageSearcher;

@end

@implementation ZHYImageWindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    NSArray<ZHYImageInfo *> *infos = self.imageSearcher.infos;
    NSLog(@"infos: %@", infos);
}

- (void)setBundle:(NSBundle *)bundle {
    if (_bundle != bundle) {
        _bundle = bundle;
        
        _imageSearcher = [[ZHYImageSearcher alloc] initWithBundle:_bundle];
    }
}

@end
