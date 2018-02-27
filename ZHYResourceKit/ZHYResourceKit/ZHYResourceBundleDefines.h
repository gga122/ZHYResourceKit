//
//  ZHYResourceBundleDefines.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 26/2/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#ifndef ZHYResourceBundleDefines_h
#define ZHYResourceBundleDefines_h

typedef NSString * ZHYResourceBundleInfoKey;

static ZHYResourceBundleInfoKey const kZHYResourceBundleName = @"zhy.resourcekit.bundle.name";
static ZHYResourceBundleInfoKey const kZHYResourceBundlePriority = @"zhy.resourcekit.bundle.priority";

NSMutableDictionary<ZHYResourceBundleInfoKey, id> *createResourceBundleTempleteInfo(void) {
    NSMutableDictionary<ZHYResourceBundleInfoKey, id> *templeteInfo = [NSMutableDictionary dictionary];
    
    [templeteInfo setObject:@"Default" forKey:kZHYResourceBundleName];
    [templeteInfo setObject:@(0) forKey:kZHYResourceBundlePriority];
    
    return templeteInfo;
}

#endif /* ZHYResourceBundleDefines_h */
