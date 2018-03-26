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


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    ZHYResourceBundle *bundle = [[ZHYResourceBundle alloc] initWithBundleName:@"testBundle" priority:100];
    
    ZHYColorInfo *colorInfo = [[ZHYColorInfo alloc] initWithColor:[NSColor blueColor] resourceName:@"blue"];
    ZHYColorWrapper *r1 = [[ZHYColorWrapper alloc] initWithResourceDescriptor:colorInfo];
    [bundle addResourceWrapper:r1];
    
    ZHYFontInfo *fontInfo = [[ZHYFontInfo alloc] initWithFont:[NSFont systemFontOfSize:14.0] resourceName:@"systemFont"];
    ZHYFontWrapper *r2 = [[ZHYFontWrapper alloc] initWithResourceDescriptor:fontInfo];
    [bundle addResourceWrapper:r2];
    
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
