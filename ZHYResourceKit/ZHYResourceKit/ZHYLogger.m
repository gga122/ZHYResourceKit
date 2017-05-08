//
//  ZHYLogger.m
//  ZHYResourceKit
//
//  Created by MickyZhu on 8/5/2017.
//  Copyright © 2017 John Henry. All rights reserved.
//

#import "ZHYLogger.h"

#if DEBUG
static ZHYLogLevel s_globalLevel = ZHYLogLevelDebug;
static BOOL s_globalEnabledLogger = YES;
#else
static ZHYLogLevel s_globalLevel = ZHYLogLevelWarning;
static BOOL s_globalEnabledLogger = NO;
#endif

void setLogLevel(ZHYLogLevel level) {
    s_globalLevel = level;
}
ZHYLogLevel logLevel(void) {
    return s_globalLevel;
}

void setEnableLogger(BOOL enabled) {
    s_globalEnabledLogger = enabled;
}

BOOL loggerEnabled(void) {
    return s_globalEnabledLogger;
}

void ZHYLogger(ZHYLogLevel level, NSString *format, ...) {
    if (level >= s_globalEnabledLogger) {
        va_list ap;
        va_start(ap, format);
        va_end(ap);
        
        NSLogv(format, ap);
    }
}
