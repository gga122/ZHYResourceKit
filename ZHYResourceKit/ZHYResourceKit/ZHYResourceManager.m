//
//  ZHYResourceManager.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceManager.h"
#import "ZHYLogger.h"

static ZHYResourceManager *s_globalManager;

@implementation ZHYResourceManager

#pragma mark - Overridden

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_globalManager = [[ZHYResourceManager alloc] init];
    });
}

- (instancetype)init {
    if (s_globalManager) {
        return s_globalManager;
    }
    
    ZHYLogDebug(@"ss: %@", s_globalManager);
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

#pragma mark - Public Methods

+ (instancetype)defaultManager {
    return s_globalManager;
}

- (BOOL)loadConfigurations:(NSString *)filePath {
    if (!filePath) {
        NSLog(@"");
        return NO;
    }
    
    [self unloadConfigurations];
    
    BOOL isDirectory = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    if (!existed || isDirectory) {

        return NO;
    }
    
    return YES;
}

- (void)unloadConfigurations {
    
}

@end
