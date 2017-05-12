//
//  ZHYResourceCenter.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceCenter.h"
#import "ZHYResourceNode+Private.h"
#import "ZHYResourceKitDefines.h"

@interface ZHYResourceCenter ()

@property (nonatomic, strong) NSDictionary<NSString *, id> *structDescriptor;

@property (nonatomic, strong) NSMutableArray<ZHYResourceNode *> *nodes;

@property (nonatomic, strong) NSCache *cachedResources;

@end

@implementation ZHYResourceCenter

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithBundle:(NSBundle *)bundle {
    if (!bundle) {
        ZHYLogWarning(@"can not init from nil");
        return nil;
    }
    
    self = [super init];
    if (self) {
        _bundle = bundle;
    }
    
    [self loadStructDescriptor:_bundle];
    [self awakeFromStructDescriptor:self.structDescriptor];
    
    return self;
}

#pragma mark - Private Methods

- (BOOL)loadStructDescriptor:(NSBundle *)bundle {
    if (!bundle) {
        ZHYLogError(@"bundle is nil");
        return NO;
    }
    
    NSString *descriptorFilePath = [[bundle resourcePath] stringByAppendingPathComponent:kZHYResourceStructDescriptorFileName];
    BOOL isDirectory = NO;
    BOOL existed = [[NSFileManager defaultManager] fileExistsAtPath:descriptorFilePath isDirectory:&isDirectory];
    if (!existed || isDirectory) {
        ZHYLogError(@"Invalid file path. <bundle: %@><descriptorFilePath: %@>", bundle, descriptorFilePath);
        return NO;
    }
    
    self.structDescriptor = [NSDictionary dictionaryWithContentsOfFile:descriptorFilePath];
    if (!self.structDescriptor) {
        ZHYLogError(@"Invalid configuration format.");
        return NO;
    }
    
    return YES;
}

- (void)awakeFromStructDescriptor:(NSDictionary<NSString *, id> *)structDescriptor {
    if (structDescriptor.count == 0) {
        return;
    }
    
    self.nodes = [NSMutableArray array];
    NSArray *fontsDescriptor = [structDescriptor objectForKey:kZHYResourceKeyTypeFont];
    if (fontsDescriptor) {
        ZHYResourceNode *fontNode = [[ZHYResourceNode alloc] initWithName:kZHYResourceNodeNameFont];
        [self.nodes addObject:fontNode];
    }
    
    
}

@end
