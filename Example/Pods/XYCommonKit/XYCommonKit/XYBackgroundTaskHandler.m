//
//  XYBackgroundTaskHandler.m
//  Pods
//
//  Created by hongru qi on 2017/5/19.
//
//

#import "XYBackgroundTaskHandler.h"

@implementation XYBackgroundTaskHandler

+ (UIBackgroundTaskIdentifier)beginBackgroundTask:(void(^ __nullable)(void))handler
{
    UIBackgroundTaskIdentifier backgroundTaskId = UIBackgroundTaskInvalid;
    if ( [UIDevice currentDevice].isMultitaskingSupported ) {
        backgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            if (handler) {
                handler();
            }
        }];
    }
    return backgroundTaskId;
}

+ (void)endBackgroundTask:(UIBackgroundTaskIdentifier)backgroundTaskId
{
    if ( backgroundTaskId != UIBackgroundTaskInvalid ) {
        [[UIApplication sharedApplication] endBackgroundTask:backgroundTaskId];
    }
}

@end
