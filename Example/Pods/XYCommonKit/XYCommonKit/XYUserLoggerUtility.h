//
//  XYUserBehaviorUtility.h
//  XiaoYingCoreSDK
//
//  Created by hongru qi on 2017/6/15.
//  Copyright © 2017年 QuVideo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYUserLoggerUtility : NSObject

#pragma mark --utiltiy method
+ (NSString *)getVideoPlayBufferCountStr:(NSInteger)count;
//in Millisecond
+ (NSString *)getVideoPlayBufferDurationStr:(unsigned long)duration;

+ (NSString *)getDurationStr:(unsigned long)duration;

+ (NSString *)getFileSizeStr:(unsigned long long)fileSize;

+ (NSString *)getFileSizeStrVivaDiva:(unsigned long long)fileSize;

+ (NSString *)getFPSStr:(int)fps;

+ (NSString *)getFPSStrVivaDiva:(int)fps;

//in Millisecond
+ (NSString *)getTimeRatioStr:(unsigned long long)timeSpend duration:(unsigned long long)duration;

+ (NSString *)getAmountStr:(int)amount;

+ (NSString *)getPhotoAmountStr:(int)amount;

+ (NSString *)getVideoAmountStr:(int)amount;

+ (NSString *)getDraftCountStr:(NSInteger)amount;

+ (NSString *)getResolutionStr:(NSString *)resolutions;

+ (NSString *)getTemplateDownloadDurationStr:(long long)duration;

+ (NSString *)getAPIRequestDurationStr:(long long)durationInMilliseconds;

+ (NSString *)getProgressStr:(float)progress;

+ (NSString *)getExportCostTimeStr:(unsigned long long)second;

@end
