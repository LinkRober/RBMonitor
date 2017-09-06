//
//  XYBackgroundTaskMgr.m
//  XiaoYingCoreSDK
//
//  Created by 徐新元 on 20/01/2017.
//  Copyright © 2017 QuVideo. All rights reserved.
//

#import "XYBackgroundTaskMgr.h"

@implementation XYBackgroundTaskMgr

#pragma mark - BackgroundTask
+ (UIBackgroundTaskIdentifier)beginBackgroundTask:(void(^ __nullable)(void))handler
{
    UIBackgroundTaskIdentifier backgroundTaskId = UIBackgroundTaskInvalid;
    if ( [UIDevice currentDevice].isMultitaskingSupported ) {
        backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"Background Task expired");
            if (handler) {
                handler();
            }
        }];
        NSLog(@"Background Task %@ started",@(backgroundTaskId));
    }
    return backgroundTaskId;
}

+ (void)endBackgroundTask:(UIBackgroundTaskIdentifier)backgroundTaskId
{
    if ( backgroundTaskId != UIBackgroundTaskInvalid ) {
        NSLog(@"Background Task %@ ended",@(backgroundTaskId));
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
    }
}

@end
