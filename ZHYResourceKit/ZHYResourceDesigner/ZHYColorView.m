//
//  ZHYColorView.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 23/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYColorView.h"

@implementation ZHYColorView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    if (self.backgroundColor) {
        [self.backgroundColor set];
    } else {
        [[NSColor whiteColor] set];
    }
    
    NSRectFill(dirtyRect);
}

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    if (_backgroundColor != backgroundColor) {
        _backgroundColor = [backgroundColor copy];
        
        self.needsDisplay = YES;
    }
}

@end
