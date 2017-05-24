//
//  ZHYBundleLoader.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYResourceKitDefines.h"
#import "ZHYResourceNode+Private.h"
#import "ZHYResourceCenter+Private.h"
#import "ZHYResourceManager+Private.h"

static ZHYBundleLoader *s_globalBundleLoader = nil;

@interface ZHYBundleLoader ()

@end

@implementation ZHYBundleLoader

#pragma mark - Overridden

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_globalBundleLoader = [[ZHYBundleLoader alloc] init];
    });
}


- (instancetype)init {
    if (s_globalBundleLoader) {
        return s_globalBundleLoader;
    }
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - Public Methods

+ (instancetype)defaultLoader {
    return s_globalBundleLoader;
}

- (void)loadBundle:(NSBundle *)bundle {
    [self synchonizePlist];
    [[ZHYResourceManager defaultManager] loadBundle:bundle];
}

- (BOOL)addResourceInfo:(id<ZHYResourceInfo>)resourceInfo inClassification:(NSString *)classification {
    if (!resourceInfo) {
        return NO;
    }
    
    ZHYResourceNode *node = [self resourceNodeForClassification:classification];
    if (!node) {
        return NO;
    }
    
    BOOL response = [node addResourceInfo:resourceInfo];
    return response;
}

- (BOOL)removeResourceInfo:(id<ZHYResourceInfo>)resourceInfo inClassification:(NSString *)classification {
    if (!resourceInfo) {
        return NO;
    }
    
    ZHYResourceNode *node = [self resourceNodeForClassification:classification];
    if (!node) {
        return NO;
    }
    
    BOOL response = [node removeResourceInfo:resourceInfo];
    return response;
}

- (void)synchonizePlist {
    ZHYResourceCenter *center = [ZHYResourceManager defaultManager].currentCenter;
    if (!center) {
        return;
    }
    
    NSDictionary *plist = [center archiveToPlist];
    if (!plist) {
        return;
    }
    
    NSString *bundleResourcePath = center.bundle.resourcePath;
    NSString *plistPath = [bundleResourcePath stringByAppendingPathComponent:kZHYResourceStructDescriptorFileName];
    
    [plist writeToFile:plistPath atomically:YES];
}

#pragma mark - Private Methods

- (ZHYResourceNode *)resourceNodeForClassification:(NSString *)classification {
    ZHYResourceCenter *center = [ZHYResourceManager defaultManager].currentCenter;
    if (!center) {
        return nil;
    }
    
    return [center resourceNodeForClassification:classification];
}

#pragma mark - Public Property

- (NSBundle *)bundle {
    return [ZHYResourceManager defaultManager].bundle;
}

- (NSArray<ZHYColorWrapper *> *)allColorWrappers {
    return [ZHYResourceManager defaultManager].allColorWrappers;
}

- (NSArray<ZHYFontWrapper *> *)allFontWrappers {
    return [ZHYResourceManager defaultManager].allFontWrappers;
}

- (NSArray<ZHYImageWrapper *> *)allImageWrappers {
    return [ZHYResourceManager defaultManager].allImageWrappers;
}

@end
