//
//  ZHYLogger.h
//  ZHYResourceKit
//
//  Created by MickyZhu on 8/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSUInteger, ZHYLogFlag) {
    ZHYLogFlagDebug = 1 << 0,
    ZHYLogFlagInfo = 1 << 1,
    ZHYLogFlagWarning = 1 << 2,
    ZHYLogFlagError = 1 << 3,
};

typedef NS_ENUM(NSUInteger, ZHYLogLevel) {
    ZHYLogLevelDebug = ZHYLogFlagDebug,
    ZHYLogLevelInfo = ZHYLogFlagDebug | ZHYLogFlagInfo,
    ZHYLogLevelWarning = ZHYLogFlagDebug | ZHYLogFlagInfo | ZHYLogFlagWarning,
    ZHYLogLevelError = ZHYLogFlagDebug | ZHYLogFlagInfo | ZHYLogFlagWarning | ZHYLogFlagError,
};

void setLogLevel(ZHYLogLevel level);
ZHYLogLevel logLevel(void);

void setEnableLogger(BOOL enabled);
BOOL loggerEnabled(void);

void ZHYLogger(ZHYLogLevel level, NSString *format, ...);

#define ZHYLogDebug(frmt, ...) ZHYLogger(ZHYLogLevelDebug, frmt, ##__VA_ARGS__)
#define ZHYLogInfo(frmt, ...) ZHYLogger(ZHYLogLevelInfo, frmt, ##__VA_ARGS__)
#define ZHYLogWarning(frmt, ...) ZHYLogger(ZHYLogLevelWarning, frmt, ##__VA_ARGS__)
#define ZHYLogError(frmt, ...) ZHYLogger(ZHYLogLevelError, frmt, ##__VA_ARGS__)
