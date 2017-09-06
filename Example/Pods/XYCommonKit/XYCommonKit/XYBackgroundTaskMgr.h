//
//  XYBackgroundTaskMgr.h
//  XiaoYingCoreSDK
//
//  Created by 徐新元 on 20/01/2017.
//  Copyright © 2017 QuVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYBackgroundTaskMgr : NSObject

+ (UIBackgroundTaskIdentifier)beginBackgroundTask:(void(^ __nullable)(void))handler;

+ (void)endBackgroundTask:(UIBackgroundTaskIdentifier)backgroundTaskId;

@end
