//
//  ZHYResourceMap.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 15/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYResourceMap.h"
#import <ZHYResourceKitDefines.h>

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

+ (Class)wrapperForClassification:(NSString *)classification;
+ (Class)infoForClassification:(NSString *)classification;

+ (NSMutableDictionary<NSString *, Class> *)wrappersMap;
+ (NSMutableDictionary<NSString *, Class> *)infosMap;

@end

@implementation ZHYResourceMap

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
