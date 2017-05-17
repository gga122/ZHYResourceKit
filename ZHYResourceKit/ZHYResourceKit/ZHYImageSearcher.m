//
//  ZHYImageSearcher.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageSearcher.h"
#import "ZHYResourceKitDefines.h"

static NSArray<NSString *> *s_globalImageFilters = nil;

@interface ZHYImageSearcher ()

@property (nonatomic, strong) NSArray<NSString *> *imagePaths;

@end

@implementation ZHYImageSearcher

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _bundle = bundle;
        
        _imagePaths = [self imagePathsForBundle:_bundle];
        _infos = [self infosWithPaths:_imagePaths];
        _metaInfos = [self metaInfosForInfos:_infos];
    }
    
    return self;
}

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYImageSearcher class]) {
        s_globalImageFilters = @[@"jpg", @"png"];
    }
}

- (instancetype)init {
    return [self initWithBundle:nil];
}

#pragma mark - Public Methods

+ (void)setImageFilters:(NSArray<NSString *> *)imageFilters {
    s_globalImageFilters = imageFilters;
}

+ (NSArray<NSString *> *)imageFilters {
    return s_globalImageFilters;
}

#pragma mark - Private Methods

- (NSArray<NSString *> *)imagePathsForBundle:(NSBundle *)bundle {
    if (!bundle) {
        ZHYLogWarning(@"search bundle is nil");
        return nil;
    }
    
    NSMutableArray<NSString *> *imagePaths = [NSMutableArray array];
    
    NSArray<NSString *> *extensions = [[self class] imageFilters];
    for (NSString *aExtension in extensions) {
        NSArray<NSString *> *extensionPaths = [bundle pathsForResourcesOfType:aExtension inDirectory:nil];
        [imagePaths addObjectsFromArray:extensionPaths];
    }
    
    return imagePaths;
}

- (NSArray<ZHYImageInfo *> *)infosWithPaths:(NSArray<NSString *> *)paths {
    if (paths.count == 0) {
        return nil;
    }
    
    NSMutableArray<ZHYImageInfo *> *infos = [NSMutableArray array];
    
    for (NSString *aPath in paths) {
        ZHYImageInfo *aInfo = [self infoForPath:aPath];
        if (aInfo) {
            [infos addObject:aInfo];
        } else {
            ZHYLogError(@"can not create image info with '%@'", aPath);
        }
    }
    
    return infos;
}

- (ZHYImageInfo *)infoForPath:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    NSString *lastComponent = path.lastPathComponent;
    NSUInteger length = lastComponent.length;
    
    NSString *fileName = nil;
    
    for (NSUInteger i = 0; i < length; ++i) {
        NSUInteger index = length - 1 - i;
        unichar c = [lastComponent characterAtIndex:index];
        
        if (c == '.') {
            fileName = [lastComponent substringToIndex:index];
        }
    }
    
    if (!fileName) {
        return nil;
    }
    
    ZHYImageInfo *info = [[ZHYImageInfo alloc] initWithPath:path forName:fileName];
    return info;
}

- (NSArray<NSDictionary *> *)metaInfosForInfos:(NSArray<ZHYImageInfo *> *)infos {
    if (!infos) {
        return nil;
    }
    
    NSMutableArray<NSDictionary *> *metaInfos = [NSMutableArray array];
    for (ZHYImageInfo *aInfo in infos) {
        NSDictionary *metaInfo = [aInfo encodeToPlist];
        if (!metaInfos) {
            ZHYLogWarning(@"Encode to plist failed. <Info: %@>", aInfo);
            continue;
        }
        
        [metaInfos addObject:metaInfo];
    }
    
    return metaInfos;
}

@end
