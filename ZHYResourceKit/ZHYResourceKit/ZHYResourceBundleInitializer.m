//
//  ZHYResourceBundleInitializer.m
//  ZHYResourceKit
//
//  Created by Henry on 2019/1/1.
//  Copyright © 2019 John Henry. All rights reserved.
//

#import "ZHYResourceBundleInitializer.h"

static NSMutableDictionary<NSString *, ZHYResourceBundleInitializer *> *s_globalRegisterInitializers = nil;

static NSString * const kZHYResourceBundleInfoFileName = @"ZHYResourceBundleInfo.plist";
static NSString * const kZHYResourceBundleResourceDirectoryName = @"ZHYResources";

@implementation ZHYResourceBundleInitializer

#pragma mark - Public Methods

- (NSString *)bundleInfoPathWithDirectoryPath:(NSString *)path {
    if (path == nil) {
        NSParameterAssert(nil);
        return nil;
    }
    
    return [path stringByAppendingPathComponent:kZHYResourceBundleInfoFileName];
}

- (NSString *)resourcePathWithDirectoryPath:(NSString *)path {
    if (path == nil) {
        NSParameterAssert(nil);
        return nil;
    }
    
    return [path stringByAppendingPathComponent:kZHYResourceBundleResourceDirectoryName];
}

@end
