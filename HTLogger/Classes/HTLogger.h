//
//  HTLogger.h
//  CocoaLumberjack
//
//  Created by ocean on 2018/4/3.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HTLogTypeError = 1 << 0,
    HTLogTypeWarning = 1 << 1,
    HTLogTypeInfo = 1 << 2,
    HTLogTypeVerbose = 1 << 3,
} HTLogType;

typedef enum : NSUInteger {
    HTLogLevelError = HTLogTypeError,
    HTLogLevelWarning = HTLogTypeWarning | HTLogLevelError,
    HTLogLevelInfo = HTLogTypeInfo | HTLogLevelWarning,
    HTLogLevelVerbose = HTLogTypeVerbose | HTLogLevelInfo,
} HTLogLevel;

#define HTLogError(fmt,...) \
[[HTLogger defaultLogger] log:[NSString stringWithFormat:fmt, __VA_ARGS__] type:HTLogTypeError]
#define HTLogWarn(fmt,...) \
[[HTLogger defaultLogger] log:[NSString stringWithFormat:fmt, __VA_ARGS__] type:HTLogTypeWarning]
#define HTLogInfo(fmt,...) \
[[HTLogger defaultLogger] log:[NSString stringWithFormat:fmt, __VA_ARGS__] type:HTLogTypeInfo]
#define HTLogVerbose(fmt,...) \
[[HTLogger defaultLogger] log:[NSString stringWithFormat:fmt, __VA_ARGS__] type:HTLogTypeVerbose]

@interface HTLogger : NSObject
+ (HTLogger *)defaultLogger;
- (void)log:(NSString *)content type:(HTLogType)logType;
- (void)setLogLevel:(HTLogLevel)logLevel;
- (NSArray *)logFiles;
@end
