//
// Created by ocean on 2018/4/3.
//

#import "HTLoggerShareFetcher.h"
#import "HTLogger.h"
#import <UIKit/UIKit.h>

@implementation HTLoggerShareFetcher {

}

+ (void)fetchLogArchive {
    NSArray *logFiles = [[HTLogger defaultLogger] logFiles];
    NSMutableString *mergeString = [NSMutableString new];
    for (NSString *path in logFiles) {
        NSString *content = [NSString stringWithContentsOfFile:path];
        [mergeString appendFormat:@"%@\n", content];
    }
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *mergeLogFilePath = [docPath stringByAppendingPathComponent:@"merged.log"];
    [mergeString writeToFile:mergeLogFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [self shareLogger:mergeLogFilePath];
}

+ (void)shareLogger:(NSString *)logFile {
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:@[[NSURL fileURLWithPath:logFile]] applicationActivities:@[]];
    vc.completionWithItemsHandler = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {

    };
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:vc animated:YES completion:nil];
}
@end
