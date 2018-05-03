//
//  AppDelegate.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "AppDelegate.h"

#import "ZHYResourceBundle.h"
#import "ZHYBundleWindowController.h"


@interface AppDelegate ()

@property (nonatomic, strong) ZHYResourceBundle *currentBundle;
@property (nonatomic, strong) ZHYBundleWindowController *bundleWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

#pragma mark - Action

- (IBAction)menuItemNewDidClick:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.allowedFileTypes = @[@"bundle"];
    if ([savePanel runModal] == NSModalResponseOK) {
        ZHYResourceBundle *bundle = [[ZHYResourceBundle alloc] initWithBundleName:@"defaultBundle" priority:0];
        
        NSString *filePath = savePanel.URL.path;
        [bundle writeToContentPath:filePath];
        
        self.currentBundle = bundle;
    }
}

- (IBAction)menuItemOpenDidClick:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    openPanel.allowedFileTypes = @[@"bundle"];
    if ([openPanel runModal] == NSModalResponseOK) {
        NSString *filePath = openPanel.URL.path;
        NSBundle *bundle = [NSBundle bundleWithPath:filePath];
        ZHYResourceBundle *resourceBundle = [ZHYResourceBundle resourceBundleWithBundle:bundle];
        
        self.currentBundle = resourceBundle;
        
        [self.bundleWindowController close];
        
        ZHYBundleWindowController *bundleWindowController = [[ZHYBundleWindowController alloc] initWithResourceBundle:resourceBundle];
        [bundleWindowController.window makeKeyAndOrderFront:nil];
        
        self.bundleWindowController = bundleWindowController;
    }
}

- (IBAction)menuItemCloseDidClick:(id)sender {

}

@end
