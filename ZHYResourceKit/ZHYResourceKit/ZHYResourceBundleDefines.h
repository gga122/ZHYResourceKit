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
static NSString * const kZHYResourceBundleSerializerKeyInfoFileName = @"ZHYResourceBundleInfo.plist";

static ZHYResourceBundleInfoKey const kZHYResourceBundleMagic = @"zhy.resource.bundle.magic";
static ZHYResourceBundleInfoKey const kZHYResourceBundleName = @"zhy.resourcekit.bundle.name";
static ZHYResourceBundleInfoKey const kZHYResourceBundlePriority = @"zhy.resourcekit.bundle.priority";

static NSString * const kZHYResourceBundleMagicValue = @"D473E2BB-79EC-43C9-919A-59A78BC32F24";

NSMutableDictionary<ZHYResourceBundleInfoKey, id> *createResourceBundleTempleteInfo(void) {
    NSMutableDictionary<ZHYResourceBundleInfoKey, id> *templeteInfo = [NSMutableDictionary dictionary];
    
    [templeteInfo setObject:kZHYResourceBundleMagicValue forKey:kZHYResourceBundleMagic];
    [templeteInfo setObject:@"Default" forKey:kZHYResourceBundleName];
    [templeteInfo setObject:@(0) forKey:kZHYResourceBundlePriority];
    
    return templeteInfo;
}



BOOL isValidResourceBundleInfo(NSMutableDictionary<ZHYResourceBundleInfoKey, id> *info, NSError **error) {
    if (info == nil || info.count == 0) {
        return NO;
    }
    
    id magic = [info objectForKey:kZHYResourceBundleMagic];
    if (![magic isKindOfClass:[NSString class]]) {
        ZHY_RESOURCE_KIT_ERROR(*error, kZHYResourceKitErrorDomain, ZHYResourceKitErrorCodeInvalidBundleInfo, nil);
        return NO;
    }
    
    // TODO: other values
    
    return YES;
}

#endif /* ZHYResourceBundleDefines_h */
