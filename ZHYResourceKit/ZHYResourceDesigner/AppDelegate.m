//
//  AppDelegate.m
//  ZHYResourceDesigner
//
//  Created by MickyZhu on 10/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "AppDelegate.h"

#import "ZHYResourceBundle.h"
#import "ZHYColorWrapper.h"
#import "ZHYFontWrapper.h"

@interface AppDelegate ()

@property (nonatomic, strong) ZHYResourceBundle *currentBundle;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
//    ZHYResourceBundle *bundle = [[ZHYResourceBundle alloc] initWithBundleName:@"testBundle" priority:100];
//
//    ZHYColorInfo *colorInfo = [[ZHYColorInfo alloc] initWithColor:[NSColor blueColor] resourceName:@"blue"];
//    ZHYColorWrapper *r1 = [[ZHYColorWrapper alloc] initWithResourceDescriptor:colorInfo];
//    [bundle addResourceWrapper:r1];
//
//    ZHYFontInfo *fontInfo = [[ZHYFontInfo alloc] initWithFont:[NSFont systemFontOfSize:14.0] resourceName:@"systemFont"];
//    ZHYFontWrapper *r2 = [[ZHYFontWrapper alloc] initWithResourceDescriptor:fontInfo];
//    [bundle addResourceWrapper:r2];
//
//    NSSavePanel *savePanel = [NSSavePanel savePanel];
//    savePanel.allowedFileTypes = @[@"bundle"];
//    [savePanel runModal];
//
//    NSString *filePath = savePanel.URL.path;
//    [bundle writeToFile:filePath atomically:YES];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    
}

- (IBAction)menuItemNewDidClick:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.allowedFileTypes = @[@"bundle"];
    if ([savePanel runModal] == NSModalResponseOK) {
        ZHYResourceBundle *bundle = [[ZHYResourceBundle alloc] initWithBundleName:@"defaultBundle" priority:0];
        
        NSString *filePath = savePanel.URL.path;
        [bundle writeToFile:filePath atomically:YES];
        
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
    }
}

- (IBAction)menuItemCloseDidClick:(id)sender {

}

@end
