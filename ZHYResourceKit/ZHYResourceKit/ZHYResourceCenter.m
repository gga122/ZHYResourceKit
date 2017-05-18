//
//  ZHYResourceCenter.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 5/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYResourceCenter+Private.h"
#import "ZHYResourceNode+Private.h"
#import "ZHYResourceKitDefines.h"

@interface ZHYResourceCenter ()

@property (nonatomic, strong) NSDictionary<NSString *, id> *structDescriptor;

@property (nonatomic, strong) NSMutableArray<ZHYResourceNode *> *nodes;
@property (nonatomic, strong) NSMutableDictionary<NSString *, ZHYResourceNode *> *nodesMap;

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

#pragma mark - Public Methods

- (ZHYResourceNode *)resourceNodeForClassification:(NSString *)classification {
    if (!classification) {
        return nil;
    }
    
    return [self.nodesMap objectForKey:classification];
}

- (id)resourceForName:(NSString *)name ofClassification:(NSString *)classification {
    if (!name) {
        return nil;
    }
    
    id resource = nil;
    
    if (classification) {
        ZHYResourceNode *node = [self.nodesMap objectForKey:classification];
        resource = [node resourceForName:name];
    } else {
        NSArray<ZHYResourceNode *> *nodes = [NSArray arrayWithArray:self.nodes];
        
        for (ZHYResourceNode *aNode in nodes) {
            resource = [aNode resourceForName:name];
            if (resource) {
                break;
            }
        }
    }

    return resource;
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
    
    self.nodes = [NSMutableArray arrayWithCapacity:structDescriptor.count];
    self.nodesMap = [NSMutableDictionary dictionaryWithCapacity:structDescriptor.count];
    
    NSMutableArray<NSString *> *allClassifications = [NSMutableArray arrayWithArray:structDescriptor.allKeys];
    
    /* ResourceKit reserved classifications */
    NSArray<NSString *> *reservedClassfications = [[self class] resourceKitReservedClassifications];
    for (NSString *aReserved in reservedClassfications) {
        NSArray<NSDictionary *> *metaResourceInfos = [structDescriptor objectForKey:aReserved];
        if (!metaResourceInfos) {
            continue;
        }
        
        ZHYResourceNode *aReservedNode = [[ZHYResourceNode alloc] initWithClassification:aReserved metaInfos:metaResourceInfos];
        
        [self.nodes addObject:aReservedNode];
        [self.nodesMap setObject:aReservedNode forKey:aReserved];
    }
    [allClassifications removeObjectsInArray:reservedClassfications];  // remove reserved classifications

    /* User custom classifications */
    for (NSString *aCustom in allClassifications) {
        NSArray<NSDictionary *> *metaResourceInfos = [structDescriptor objectForKey:aCustom];
        if (!metaResourceInfos) {
            continue;
        }
        
        ZHYResourceNode *aCustomNode = [[ZHYResourceNode alloc] initWithClassification:aCustom metaInfos:metaResourceInfos];
        
        [self.nodes addObject:aCustomNode];
        [self.nodesMap setObject:aCustomNode forKey:aCustom];
    }
}

+ (NSArray<NSString *> *)resourceKitReservedClassifications {
    static NSArray<NSString *> *s_globalZHYResourceKitReservedClassifications = nil;
    if (!s_globalZHYResourceKitReservedClassifications) {
        s_globalZHYResourceKitReservedClassifications = @[kZHYResourceKeyTypeColor, kZHYResourceKeyTypeFont, kZHYResourceKeyTypeImage];
    }
    
    return s_globalZHYResourceKitReservedClassifications;
}

- (NSDictionary<NSString *, id> *)archiveToPlist {
    NSMutableDictionary *centerPlist = [NSMutableDictionary dictionary];
    
    for (ZHYResourceNode *aNode in self.nodes) {
        NSArray *resourceList = [aNode archiveToPlist];
        
        if (!resourceList) {
            continue;
        }
        
        [centerPlist setObject:resourceList forKey:aNode.classification];
    }
    
    return centerPlist;
}

#pragma mark - Private Property

- (NSArray<ZHYResourceNode *> *)subNodes {
    if (!self.nodes) {
        return nil;
    }
    
    return [NSArray arrayWithArray:self.nodes];
}

@end
