//
//  AppDelegate.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHYMainWindowController.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSWindowController *mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _mainWindowController = [[ZHYMainWindowController alloc] initWithWindowNibName:@"ZHYMainWindowController"];
    
    [self.mainWindowController.window makeKeyAndOrderFront:nil];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
