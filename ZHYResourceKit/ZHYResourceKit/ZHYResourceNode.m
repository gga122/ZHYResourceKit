//
//  ZHYResourceNode.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceNode+Private.h"

NSString * const kZHYResourceNodeNameImage = @"kZHYResourceImage";
NSString * const kZHYResourceNodeNameFont = @"kZHYResourceFont";
NSString * const kZHYResourceNodeNameColor = @"kZHYResourceColor";

@interface ZHYResourceNode ()

@property (nonatomic, strong) NSMutableArray *resources;
@property (nonatomic, strong) NSMutableDictionary *resourcesMap;

@end

@implementation ZHYResourceNode

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithName:(NSString *)name {
    if (!name) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    
    return self;
}

#pragma mark - Overridden

@end
