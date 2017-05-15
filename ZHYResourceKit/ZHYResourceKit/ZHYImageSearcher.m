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
    }
    
    return self;
}

#pragma mark - Overridden

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_globalImageFilters = @[@"jpg", @"png"];
    });
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
        NSArray<NSString *> extensionPaths = [bundle pathsForResourcesOfType:aExtension inDirectory:nil];
        [imagePaths addObjectsFromArray:extensions];
    }
    
    return imagePaths;
}

@end
