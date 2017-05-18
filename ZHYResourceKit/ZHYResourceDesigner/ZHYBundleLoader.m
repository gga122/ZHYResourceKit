//
//  ZHYBundleLoader.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 18/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYBundleLoader.h"
#import "ZHYResourceMap.h"
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
    if (bundle) {
        [[ZHYResourceManager defaultManager] loadBundle:bundle];
    }
}

- (BOOL)addResourceInfo:(id<ZHYResourceInfo>)resourceInfo inClassification:(NSString *)classification {
    if (!resourceInfo) {
        return NO;
    }
    
    ZHYResourceNode *node = [self resourceNodeForClassification:classification];
    if (!node) {
        return NO;
    }
    
    id resource = [node resourceForName:resourceInfo.name];
    if (resource) {
        return NO;
    }
        
    
    return YES;
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