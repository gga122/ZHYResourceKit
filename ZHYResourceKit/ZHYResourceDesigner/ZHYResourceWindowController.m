//
//  ZHYResourceWindowController.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceWindowController.h"

@interface ZHYResourceWindowController ()

@property (weak) IBOutlet NSView *contentView;

@end

@implementation ZHYResourceWindowController

- (instancetype)initWithBusinessViewController:(NSViewController *)viewController {
    self = [super initWithWindowNibName:@"ZHYResourceWindowController"];
    if (self) {
        _businessViewController = viewController;
    }
    
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.contentView addSubview:self.businessViewController.view];
    
    self.businessViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDictionary = @{@"business": self.businessViewController.view};
    
    NSArray<NSLayoutConstraint *> *horizon = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[business]-(0)-|" options:0 metrics:nil views:viewDictionary];
    [self.contentView addConstraints:horizon];
    
    NSArray<NSLayoutConstraint *> *vertical = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[business]-(0)-|" options:0 metrics:nil views:viewDictionary];
    [self.contentView addConstraints:vertical];
}

- (IBAction)addButtonDidClick:(id)sender {
    
}

- (IBAction)removeButtonDidClick:(id)sender {
    
}

@end
