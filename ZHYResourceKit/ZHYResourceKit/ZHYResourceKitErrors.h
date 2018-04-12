//
//  ZHYResourceKitErrors.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 7/3/2018.
//  Copyright © 2018 John Henry. All rights reserved.
//

#ifndef ZHYResourceKitErrors_h
#define ZHYResourceKitErrors_h

#define ZHY_RESOURCE_KIT_ERROR(m_error, m_domain, m_code, m_userInfo)\
if (m_error) {\
m_error = [NSError errorWithDomain:m_domain code:m_code userInfo:m_userInfo];\
}\

static NSErrorDomain const kZHYResourceKitErrorDomain = @"ZHYResourceKitError";

/* Bundle Info */
static NSUInteger const kZHYResourceKitErrorBundleInfoMask = 10000;
static NSString * const kZHYResourceKitErrorBundleInfoKey = @"ZHYResourceBundleInfoKey";

typedef NS_ENUM(NSInteger, ZHYResourceKitErrorCode) {
    ZHYResourceKitErrorCodeNone                                 = 0,
    
    ZHYResourceKitErrorCodeInvalidBundleInfo                    = kZHYResourceKitErrorBundleInfoMask | 1,
        
};




#endif /* ZHYResourceKitErrors_h */
