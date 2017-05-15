//
//  ZHYImageTransformer.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageTransformer.h"
#import "ZHYResourceManager+Private.h"

NSValueTransformerName const kZHYImageTransformer = @"zhy.resourceKit.transformer.image";

@implementation ZHYImageTransformer

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ZHYImageTransformer *transformer = [[ZHYImageTransformer alloc] init];
        [[self class] setValueTransformer:transformer forName:kZHYImageTransformer];
    });
}

- (ZHYImage *)transformedValue:(NSString *)path  {
    return [self imageForPath:path];
}

- (NSString *)reverseTransformedValue:(ZHYImage *)image {
    return nil;
}

#pragma mark - Private Methods

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
