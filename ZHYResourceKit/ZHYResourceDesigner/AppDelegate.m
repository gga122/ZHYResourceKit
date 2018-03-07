//
//  AppDelegate.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHYMainWindowController.h"

#import "ZHYResourceBundle.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSWindowController *mainWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _mainWindowController = [[ZHYMainWindowController alloc] initWithWindowNibName:@"ZHYMainWindowController"];
    
    [self.mainWindowController.window makeKeyAndOrderFront:nil];
    
    ZHYResourceBundle *bundle = [[ZHYResourceBundle alloc] initWithBundleName:@"testBundle" priority:100];
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.allowedFileTypes = @[@"bundle"];
    [savePanel runModal];
    
    NSString *filePath = savePanel.URL.path;
    [bundle writeToFile:filePath atomically:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
