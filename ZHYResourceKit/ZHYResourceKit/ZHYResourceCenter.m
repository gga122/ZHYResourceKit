//
//  ZHYResourceCenter.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceCenter.h"

@implementation ZHYResourceCenter

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        _bundle = bundle;
    }
    
    NSArray<NSString *> *directories = [self updateIndex];
    
    return self;
}

#pragma mark - Overridden

- (instancetype)init {
    return [self initWithBundle:[NSBundle mainBundle]];
}

#pragma mark - Private Methods

- (NSArray<NSString *> *)updateIndex {
    if ([self.bundle isEqual:[NSBundle mainBundle]]) {
        
    }
    
    NSString *resourcePath = [self.bundle resourcePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator<NSString *> *enumerator = [fileManager enumeratorAtPath:resourcePath];
    
    
    NSArray<NSString *> *subPaths = [fileManager subpathsAtPath:resourcePath];
        
    NSArray<NSString *> *directories = [fileManager subpathsOfDirectoryAtPath:resourcePath error:nil];
    
    return directories;
}

@end
