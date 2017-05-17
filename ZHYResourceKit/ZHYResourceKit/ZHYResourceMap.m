//
//  ZHYResourceMap.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceMap.h"
#import "ZHYResourceKitDefines.h"

static NSLock *s_globalLock = nil;

#define G_LOCK(flag)\
if (flag) {\
    [s_globalLock lock];\
}\

#define G_UNLOCK(flag)\
if (flag) {\
    [s_globalLock unlock];\
}\

@interface ZHYResourceMap ()

+ (NSMutableDictionary<NSString *, Class> *)wrappersMap;
+ (NSMutableDictionary<NSString *, Class> *)infosMap;

@end

@implementation ZHYResourceMap

#pragma mark - Overridden

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self registerWrapper:NSClassFromString(@"ZHYImageWrapper") forClassification:kZHYResourceKeyTypeImage willLock:NO];
        [self registerResourceInfo:NSClassFromString(@"ZHYImageInfo") forClassification:kZHYResourceKeyTypeImage willLock:NO];
        
        [self registerWrapper:NSClassFromString(@"ZHYColorWrapper") forClassification:kZHYResourceKeyTypeColor willLock:NO];
        [self registerResourceInfo:NSClassFromString(@"ZHYColorInfo") forClassification:kZHYResourceKeyTypeColor willLock:NO];
        
        [self registerWrapper:NSClassFromString(@"ZHYFontWrapper") forClassification:kZHYResourceKeyTypeFont willLock:NO];
        [self registerResourceInfo:NSClassFromString(@"ZHYFontInfo") forClassification:kZHYResourceKeyTypeFont willLock:NO];
    });
}

#pragma mark - Public Methods

+ (void)registerWrapper:(Class)wrapper forClassification:(NSString *)classification {
    [self registerWrapper:wrapper forClassification:classification willLock:YES];
}

+ (void)unregisterWrapperForClassification:(NSString *)classification {
    [self unregisterWrapperForClassification:classification willLock:YES];
}

+ (void)registerResourceInfo:(Class)info forClassification:(NSString *)classification {
    [self registerResourceInfo:info forClassification:classification willLock:YES];
}

+ (void)unregisterResourceInfoForClassification:(NSString *)classification {
    [self unregisterResourceInfoForClassification:classification willLock:YES];
}

#pragma mark - Private Methods

+ (void)registerWrapper:(Class)wrapper forClassification:(NSString *)classification willLock:(BOOL)lock {
    if (!wrapper || !classification) {
        return;
    }
    
    if (![wrapper isSubclassOfClass:[ZHYResourceWrapper class]]) {
        return;
    }
    
    G_LOCK(lock);
    [[self wrappersMap] setObject:wrapper forKey:classification];
    G_UNLOCK(lock);
}

+ (void)unregisterWrapperForClassification:(NSString *)classification willLock:(BOOL)lock {
    if (!classification) {
        return;
    }
    
    G_LOCK(lock);
    [[self wrappersMap] removeObjectForKey:classification];
    G_UNLOCK(lock);
}

+ (void)registerResourceInfo:(Class)info forClassification:(NSString *)classification willLock:(BOOL)lock {
    if (!info || !classification) {
        return;
    }
    
    if (![info conformsToProtocol:@protocol(ZHYResourceInfo)]) {
        return;
    }
    
    G_LOCK(lock);
    [[self infosMap] setObject:info forKey:classification];
    G_UNLOCK(lock);
}

+ (void)unregisterResourceInfoForClassification:(NSString *)classification willLock:(BOOL)lock {
    if (!classification) {
        return;
    }
    
    G_LOCK(lock);
    [[self infosMap] removeObjectForKey:classification];
    G_UNLOCK(lock);
}

+ (Class)wrapperForClassification:(NSString *)classification {
    return [self wrapperForClassification:classification willLock:YES];
}

+ (Class)wrapperForClassification:(NSString *)classification willLock:(BOOL)lock {
    G_LOCK(lock)
    Class cls = [[self wrappersMap] objectForKey:classification];
    G_UNLOCK(lock)
    
    return cls;
}

+ (Class)infoForClassification:(NSString *)classification {
    return [self infoForClassification:classification willLock:YES];
}

+ (Class)infoForClassification:(NSString *)classification willLock:(BOOL)lock {
    G_LOCK(lock)
    Class cls = [[self infosMap] objectForKey:classification];
    G_UNLOCK(lock)
    
    return cls;
}

#pragma mark - Private Property (Class)

+ (NSMutableDictionary<NSString *, Class> *)wrappersMap {
    static NSMutableDictionary<NSString *, Class> *s_globalWrappersMap;
    if (!s_globalWrappersMap) {
        s_globalWrappersMap = [NSMutableDictionary dictionary];
    }
    
    return s_globalWrappersMap;
}

+ (NSMutableDictionary<NSString *,Class> *)infosMap {
    static NSMutableDictionary<NSString *, Class> *s_globalInfosMap;
    if (!s_globalInfosMap) {
        s_globalInfosMap = [NSMutableDictionary dictionary];
    }
    
    return s_globalInfosMap;
}

@end
