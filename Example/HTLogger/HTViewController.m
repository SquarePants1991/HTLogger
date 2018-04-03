//
//  HTViewController.m
//  HTLogger
//
//  Created by squarepants1991 on 04/03/2018.
//  Copyright (c) 2018 squarepants1991. All rights reserved.
//

#import "HTViewController.h"
#import "HTLogger/HTLogger.h"
#import "HTLogger/HTLoggerShareFetcher.h"

@interface HTViewController ()

@end

@implementation HTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HTLogError(@"Hello %@", @"world");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSArray *logFiles = [[HTLogger defaultLogger] logFiles];
    HTLogInfo(@"log files: %@", logFiles);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(nullable UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [HTLoggerShareFetcher fetchLogArchive];
    }
}

@end
