//
//  ZHYImageWrapper.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 9/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"
#import "ZHYImageWrapper.h"
#import "ZHYResourceKitDefines.h"

@implementation ZHYImageWrapper

#pragma mark - Overridden

+ (void)initialize {
    if (self == [ZHYImageWrapper self]) {
        [ZHYImageTransformer class];
    }
}

#pragma mark - Public Property

- (ZHYImage *)image {
    return self.resource;
}

+ (NSValueTransformer *)transformer {
    return [NSValueTransformer valueTransformerForName:kZHYImageTransformer];
}

@end

@interface ZHYImageInfo ()

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *representations;

- (instancetype)initWithRepresentations:(NSDictionary<NSNumber *, NSString *> *)representation resourceName:(NSString *)resourceName NS_DESIGNATED_INITIALIZER;

@end

@implementation ZHYImageInfo

#pragma mark - DESIGNATED INITIALIZER

- (instancetype)initWithImagePath:(NSString *)imagePath forResourceName:(NSString *)resourceName {
    if (imagePath == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceName = [resourceName copy];
        _representations = [NSMutableDictionary dictionaryWithCapacity:3];
        
        [_representations setObject:[imagePath copy] forKey:resourceName];
    }
    
    return self;
}

- (instancetype)initWithRepresentations:(NSDictionary<NSNumber *, NSString *> *)representation resourceName:(NSString *)resourceName {
    if (representation == nil || resourceName == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        _resourceName = [resourceName copy];
        _representations = [NSMutableDictionary dictionaryWithDictionary:representation];
    }
    
    return self;
}

#pragma mark - Overridden

- (NSString *)description {
    NSMutableString *desc = [NSMutableString stringWithString:[super description]];
    
    [desc appendFormat:@"<name: %@>", _resourceName];
    [desc appendFormat:@"<paths: %@>", _representations];
    if (_resourceDetail) {
        [desc appendFormat:@"<detail: %@>", _resourceDetail];
    }
    
    return desc;
}

- (BOOL)isEqual:(id)object {
    if (object && [object isKindOfClass:[ZHYImageInfo class]]) {
        return [self isEqualToZHYImageInfo:object];
    }
    
    return NO;
}

#pragma mark - Public Methods

- (NSString *)imagePathForScale:(CGFloat)scale {
    return [self.representations objectForKey:@(scale)];
}

- (void)setImagePath:(NSString *)path forScale:(CGFloat)scale {
    [self.representations setObject:[path copy] forKey:@(scale)];
}

- (void)removeImagePathForScale:(CGFloat)scale {
    [self.representations removeObjectForKey:@(scale)];
}

#pragma mark - Private Methods

- (BOOL)isEqualToZHYImageInfo:(ZHYImageInfo *)imageInfo {
    if (![imageInfo.resourceName isEqualToString:_resourceName]) {
        return NO;
    }
    
    if (![imageInfo.imagePaths isEqualToDictionary:_representations]) {
        return NO;
    }
    
    return YES;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    ZHYImageInfo *info = [[ZHYImageInfo allocWithZone:zone] initWithRepresentations:_representations resourceName:_resourceName];
    info->_resourceDetail = [_resourceDetail copy];
    
    return info;
}

#pragma mark - ZHYResourceDescriptor

- (id<NSCoding>)resourceContents {
    return self.imagePaths;
}

+ (NSString *)resourceType {
    return kZHYResourceKeyTypeImage;
}

#pragma mark - Private Property

- (NSDictionary *)imagePaths {
    return [self.representations copy];
}

@end
