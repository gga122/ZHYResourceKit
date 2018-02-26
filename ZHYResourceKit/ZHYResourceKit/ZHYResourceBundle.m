//
//  ZHYResourceBundle.m
//  ZHYResourceKitForMac
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#import "ZHYResourceBundle.h"
#import "ZHYLogger.h"

@interface ZHYResourceBundle ()

@property (nonatomic, strong) NSMutableArray<NSString *> *resourceTypes;

@end

@implementation ZHYResourceBundle

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundleName:(NSString *)bundleName priority:(NSUInteger)priority {
    if (bundleName == nil) {
        ZHYLogError(@"Bundle name can not be nil.");
        return nil;
    }
    
    self = [super init];
    if (self) {
        _bundleName = [bundleName copy];
        _priority = priority;
    }
    
    return self;
}

@end
