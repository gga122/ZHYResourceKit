//
//  ZHYResourceBundleDefines.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#ifndef ZHYResourceBundleDefines_h
#define ZHYResourceBundleDefines_h

#import "ZHYResourceKitDefines.h"
#import "ZHYResourceKitErrors.h"

typedef NSString * ZHYResourceBundleInfoKey;

/* profile name of resource bundle */
static NSString * const kZHYResourceBundleInfoFileName = @"ZHYResourceBundleInfo.plist";
static NSString * const kZHYResourceBundleResourceDirectoryName = @"ZHYResources";

static ZHYResourceBundleInfoKey const kZHYResourceBundleMagic = @"zhy.resourcekit.bundle.magic";
static ZHYResourceBundleInfoKey const kZHYResourceBundleName = @"zhy.resourcekit.bundle.name";
static ZHYResourceBundleInfoKey const kZHYResourceBundlePriority = @"zhy.resourcekit.bundle.priority";

static NSString * const kZHYResourceBundleMagicValue = @"D473E2BB-79EC-43C9-919A-59A78BC32F24";

static NSMutableDictionary<ZHYResourceBundleInfoKey, id> *createResourceBundleTempleteInfo(void) {
    NSMutableDictionary<ZHYResourceBundleInfoKey, id> *templeteInfo = [NSMutableDictionary dictionary];
    
    [templeteInfo setObject:kZHYResourceBundleMagicValue forKey:kZHYResourceBundleMagic];
    [templeteInfo setObject:@"Default" forKey:kZHYResourceBundleName];
    [templeteInfo setObject:@(0) forKey:kZHYResourceBundlePriority];
    
    return templeteInfo;
}



static BOOL isValidResourceBundleInfo(NSMutableDictionary<ZHYResourceBundleInfoKey, id> *info, NSError **error) {
    if (info == nil || info.count == 0) {
        return NO;
    }
    
    id magic = [info objectForKey:kZHYResourceBundleMagic];
    if (magic == nil || ![magic isKindOfClass:[NSString class]]) {
        ZHY_RESOURCE_KIT_ERROR(*error, kZHYResourceKitErrorDomain, ZHYResourceKitErrorCodeInvalidBundleInfo, @{kZHYResourceKitErrorBundleInfoKey: kZHYResourceBundleMagic});
        return NO;
    }
    
    id name = [info objectForKey:kZHYResourceBundleName];
    if (name == nil || ![name isKindOfClass:[NSString class]]) {
        ZHY_RESOURCE_KIT_ERROR(*error, kZHYResourceKitErrorDomain, ZHYResourceKitErrorCodeInvalidBundleInfo, @{kZHYResourceKitErrorBundleInfoKey: kZHYResourceBundleName});
        return NO;
    }
    
    // MARK: other values
    
    return YES;
}

static BOOL canEditResourceBundleInfoKey(ZHYResourceBundleInfoKey key) {
    if ([key isEqualToString:kZHYResourceBundleMagic]) {
        return NO;
    }
    
    if ([key isEqualToString:kZHYResourceBundleName]) {
        return NO;
    }
    
    if ([key isEqualToString:kZHYResourceBundlePriority]) {
        return NO;
    }
    
    return YES;
}

static BOOL canEditResourceBundleInfoValue(ZHYResourceBundleInfoKey key) {
    if ([key isEqualToString:kZHYResourceBundleMagic]) {
        return NO;
    }
    
    return YES;
}

#endif /* ZHYResourceBundleDefines_h */
