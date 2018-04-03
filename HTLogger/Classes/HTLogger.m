//
//  HTLogger.m
//  CocoaLumberjack
//
//  Created by ocean on 2018/4/3.
//

#import "HTLogger.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

static int ddLogLevel = DDLogLevelAll;

@implementation HTLogger {
    HTLogLevel _logLevel;
    DDFileLogger *_fileLogger;
}

+ (HTLogger *)defaultLogger {
    static HTLogger *_shared;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        _shared = [HTLogger new];
    });
    return _shared;
}

- (instancetype)init {
    if (self = [super init]) {
        _logLevel = HTLogLevelVerbose;
        _fileLogger = [DDFileLogger new];
        _fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hours
        _fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // keep 1 week log
        [DDLog addLogger:_fileLogger];
        DDTTYLogger *ttyLogger = [DDTTYLogger new];
        [DDLog addLogger:ttyLogger];
    }
    return self;
}


- (void)log:(NSString *)content type:(HTLogType)logType {
    switch (logType & _logLevel) {
        case HTLogTypeError:
            DDLogError(@"%@", content);
            break;
        case HTLogTypeWarning:
            DDLogWarn(@"%@",content);
            break;
        case HTLogTypeInfo:
            DDLogInfo(@"%@",content);
            break;
        case HTLogTypeVerbose:
            DDLogVerbose(@"%@",content);
            break;
        default:
            break;
    }
}

- (void)setLogLevel:(HTLogLevel)logLevel {
    _logLevel = logLevel;
    NSDictionary *levelMap = @{
            @(HTLogLevelError): @(DDLogLevelError),
            @(HTLogLevelWarning): @(DDLogLevelWarning),
            @(HTLogLevelInfo): @(DDLogLevelInfo),
            @(HTLogLevelVerbose): @(DDLogLevelVerbose),
    };
    ddLogLevel = [levelMap [@(logLevel)] integerValue];
}

- (NSArray *)logFiles {
    NSArray *files = [_fileLogger.logFileManager sortedLogFilePaths];
    return files;
}
@end
