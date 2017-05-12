//
//  ZHYImageWrapper+Plist.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageWrapper+Plist.h"
#import "ZHYResourceManager+Private.h"
#import "ZHYResourceKitDefines.h"

@implementation ZHYImageWrapper (Plist)

- (instancetype)initWithPlist:(NSDictionary<NSString *,NSString *> *)plist {
    NSString *name = [plist objectForKey:kZHYImageKeyName];
    if (!name) {
        ZHYLogError(@"image name is nil");
        return nil;
    }
    
    NSString *path = [plist objectForKey:kZHYImageKeyPath];
    if (!path) {
        ZHYLogError(@"image path is nil");
        return nil;
    }
    ZHYImage *image = [self imageForPath:path];
    if (!image) {
        ZHYLogError(@"Failed to create image from '%@'", path);
        return nil;
    }
    
    NSString *detail = [plist objectForKey:kZHYImageKeyDetail];
    
    return [self initWithImage:image forName:name detail:detail];
}

- (ZHYImage *)imageForPath:(NSString *)path {
    NSString *absolutedPath = [self absolutedPathForPath:path];
    if (!absolutedPath) {
        return nil;
    }
    
    ZHYImage *image = [[ZHYImage alloc] initWithContentsOfFile:absolutedPath];
    return image;
}

- (NSString *)absolutedPathForPath:(NSString *)path {
    BOOL isDirectory = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (!existed || isDirectory) {
        return nil;
    }
    
    ZHYResourceCenter *currentCenter = [ZHYResourceManager defaultManager].currentCenter;
    NSBundle *bundle = currentCenter.bundle;
    if (!bundle) {
        ZHYLogError(@"Invalid resource center, bundle is nil. <center: %@>", currentCenter);
        return nil;
    }
    
    NSString *absolutedPath = [bundle.resourcePath stringByAppendingPathComponent:path];
    return absolutedPath;
}

@end
