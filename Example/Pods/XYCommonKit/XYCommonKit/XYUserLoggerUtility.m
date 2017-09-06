//
//  XYUserBehaviorUtility.m
//  XiaoYingCoreSDK
//
//  Created by hongru qi on 2017/6/15.
//  Copyright © 2017年 QuVideo. All rights reserved.
//

#import "XYUserLoggerUtility.h"

@implementation XYUserLoggerUtility

#pragma mark -- utility method


+ (NSString *)getVideoPlayBufferCountStr:(NSInteger)count
{
    if (count>10) {
        return @">10";
    }else{
        return [NSString stringWithFormat:@"%ld",(long)count];
    }
}

+ (NSString *)getVideoPlayBufferDurationStr:(unsigned long)duration
{
    if (duration < 500) {
        return @"<0.5s";
    } else if (duration >= 500 && duration < 1000) {
        return @"0.5s-1s";
    } else if (duration >= 1000 && duration < 1500) {
        return @"1s-1.5s";
    } else if (duration >= 1500 && duration < 2000) {
        return @"1.5s-2s";
    }else if (duration >= 2000 && duration < 3000) {
        return @"2s-3s";
    }else if (duration >= 3000 && duration < 4000) {
        return @"3s-4s";
    }else if (duration >= 4000 && duration < 5000) {
        return @"4s-5s";
    }else if (duration >= 5000 && duration < 6000) {
        return @"5s-6s";
    }else if (duration >= 6000 && duration < 7000) {
        return @"6s-7s";
    }else if (duration >= 7000 && duration < 8000) {
        return @"7s-8s";
    }else if (duration >= 8000 && duration < 9000) {
        return @"8s-9s";
    }else if (duration >= 9000 && duration <= 10000) {
        return @"9s-10s";
    }else{
        return @">10s";
    }
}

+ (NSString *)getDurationStr:(unsigned long)duration
{
    if (duration <= 15000) {
        return @"<15s";
    } else if (duration > 15000 && duration <= 30000) {
        return @"15s-30s";
    } else if (duration > 30000 && duration <= 60000) {
        return @"30s-1m";
    } else if (duration > 60000 && duration <= 180000) {
        return @"1m-3m";
    }else if (duration > 180000 && duration <= 300000) {
        return @"3m-5m";
    }else if (duration > 300000 && duration <= 600000){
        return @"5m-10m";
    }else{
        return @">10m";
    }
}

+ (NSString *)getFileSizeStr:(unsigned long long)fileSize
{
    if (fileSize <= 0.5 * 1024 *1024) {
        return @"<0.5m";
    }else if (fileSize > 0.5 * 1024 *1024 && fileSize <= 1 * 1024 *1024) {
        return @"0.5m - 1m";
    }else if (fileSize > 1 * 1024 *1024 && fileSize <= 1.5 * 1024 *1024) {
        return @"1m - 1.5m";
    }else if (fileSize > 1.5 * 1024 *1024 && fileSize <= 2 * 1024 *1024) {
        return @"1.5m - 2m";
    }else if (fileSize > 2 * 1024 *1024 && fileSize <= 5 * 1024 *1024) {
        return @"2m - 5m";
    }else if (fileSize > 5 * 1024 *1024 && fileSize <= 10 * 1024 *1024) {
        return @"5m - 10m";
    }else if (fileSize > 10 * 1024 *1024 && fileSize <= 50 * 1024 *1024) {
        return @"10m - 50m";
    }else if (fileSize > 50 * 1024 *1024 && fileSize <= 100 * 1024 *1024) {
        return @"50m - 100m";
    }else {
        return @">100m";
    }
}

+ (NSString *)getFileSizeStrVivaDiva:(unsigned long long)fileSize
{
    if(fileSize <= 0.5 * 1024 *1024)
    {
        return @"0-0.5";
    }
    else if(fileSize > 0.5 * 1024 *1024 && fileSize <= 1 * 1024 *1024)
    {
        return @"0.5-1";
    }
    else if(fileSize > 1 * 1024 *1024 && fileSize <= 1.5 * 1024 *1024)
    {
        return @"1-1.5";
    }
    else if(fileSize > 1.5 * 1024 *1024 && fileSize <= 2 * 1024 *1024)
    {
        return @"1.5-2";
    }
    else
    {
        return @"2+";
    }
}

+ (NSString *)getFPSStr:(int)fps
{
    if (fps < 15) {
        return @"<15";
    }else if (fps >= 15 && fps <= 25) {
        return @"15 - 25";
    }else {
        return @">25";
    }
}

+ (NSString *)getFPSStrVivaDiva:(int)fps
{
    if(fps < 15)
    {
        return @"0-15";
    }
    else if(fps >= 15 && fps <= 25)
    {
        return @"15-25";
    }
    else
    {
        return @"25+";
    }
}

+ (NSString *)getTimeRatioStr:(unsigned long long)timeSpend duration:(unsigned long long)duration
{
    float ratio = (float)timeSpend/duration;
    if(ratio<=0.5){
        return @"<0.5";
    }
    else if(ratio>0.5 && ratio<=1.0){
        return @"0.5 - 1.0";
    }
    else if(ratio>1.0 && ratio<=1.5){
        return @"1.0 - 1.5";
    }
    else if(ratio>1.5 && ratio<=2.0){
        return @"1.5 - 2.0";
    }
    else{
        return @">2.0";
    }
    //    else if(ratio>2.0 && ratio<=5.0){
    //        return @"2.0 - 5.0";
    //    }
    //    else{
    //        return @">5.0";
    //    }
}

+ (NSString *)getAmountStr:(int)amount
{
    if(amount<=1){
        return @"1";
    }else if(amount>1 && amount<=5){
        return @"2 - 5";
    }else if(amount>5 && amount<=10){
        return @"5 - 10";
    }else if(amount>10 && amount<=20){
        return @"10 - 20";
    }else if(amount>20 && amount<=50){
        return @"20 - 50";
    }else {
        return @"50";
    }
}

+ (NSString *)getPhotoAmountStr:(int)amount
{
    if(amount <= 10){
        return @"<=10";
    }else if(amount >= 11 && amount <= 20){
        return @"11 - 20";
    }else if(amount >= 21 && amount <= 30){
        return @"21 - 30";
    }else if (amount >= 31 && amount <= 40){
        return @"31 - 40";
    }else if (amount >= 41 && amount <= 50){
        return @"41 - 50";
    }else {
        return @">50";
    }
}

+ (NSString *)getVideoAmountStr:(int)amount
{
    if (amount <= 10) {
        return [NSString stringWithFormat:@"%i",amount];
    }
    else if(amount >= 11 && amount <= 20){
        return @"11 - 20";
    }else if(amount >= 21 && amount <= 30){
        return @"21 - 30";
    }else if (amount >= 31 && amount <= 40){
        return @"31 - 40";
    }else if (amount >= 41 && amount <= 50){
        return @"41 - 50";
    }else {
        return @">50";
    }
}

+ (NSString *)getDraftCountStr:(NSInteger)amount
{
    if (amount == 0) {
        return @"0";
    }else if(amount == 1){
        return @"1";
    }else if(amount == 2){
        return @"2";
    }else if(amount == 3){
        return @"3";
    }else if(amount == 4){
        return @"4";
    }else if(amount == 5){
        return @"5";
    }else if(amount>=6 && amount<=10){
        return @"6-10";
    }else if(amount>=11 && amount<=20){
        return @"11-20";
    }else{
        return @">20";
    }
}

+ (NSString *)getResolutionStr:(NSString *)resolutions
{
    if([resolutions isEqualToString:@"480x480"]
       ||[resolutions isEqualToString:@"640x480"]
       ||[resolutions isEqualToString:@"720x1280"]
       ||[resolutions isEqualToString:@"1280x720"]
       ||[resolutions isEqualToString:@"1080x1920"]
       ||[resolutions isEqualToString:@"480x640"]
       ||[resolutions isEqualToString:@"1920x1080"]
       ||[resolutions isEqualToString:@"640x360"]
       ||[resolutions isEqualToString:@"320x240"]
       ||[resolutions isEqualToString:@"640x640"]
       ||[resolutions isEqualToString:@"640x368"]
       ||[resolutions isEqualToString:@"176x144"]
       ||[resolutions isEqualToString:@"852x480"]
       ||[resolutions isEqualToString:@"480x852"]){
        return resolutions;
    }else{
        return @"Others";
    }
}

+ (NSString *)getTemplateDownloadDurationStr:(long long)duration{
    NSString* strDuration;
    if (duration <= 1) {
        strDuration = @"1s";
    } else if (duration <= 5) {
        strDuration = [NSString stringWithFormat:@"%lld",duration];
    }else if (duration <= 10) {
        strDuration = @"5-10s";
    }else if (duration <= 20) {
        strDuration = @"10-20s";
    }else if (duration <= 30) {
        strDuration = @"20-30s";
    }else {
        strDuration = @">30s";
    }
    return strDuration;
}


+ (NSString *)getAPIRequestDurationStr:(long long)durationInMilliseconds{
    NSString* strDuration;
    if (durationInMilliseconds < 1000) {
        int duration = (int)(durationInMilliseconds / 100);
        strDuration = [NSString stringWithFormat:@"%d-%dms",duration*100,(duration+1)*100];
    }else if (durationInMilliseconds <= 10000) {
        int duration = (int)(durationInMilliseconds / 1000);
        strDuration = [NSString stringWithFormat:@"%d-%ds",duration,(duration+1)];
    }else if (durationInMilliseconds <= 15000) {
        strDuration = @"10-15s";
    }else if (durationInMilliseconds <= 20000) {
        strDuration = @"10-20s";
    }else if (durationInMilliseconds <= 30000) {
        strDuration = @"20-30s";
    }else {
        strDuration = @">30s";
    }
    return strDuration;
}

+ (NSString *)getProgressStr:(float)progress {
    NSString* strProgress;
    if (progress <0.1) {
        strProgress = @"<10%";
    }else if (progress < 0.2) {
        strProgress = @"10-20%";
    }else if (progress < 0.3) {
        strProgress = @"20-30%";
    }else if (progress < 0.4) {
        strProgress = @"30-40%";
    }else if (progress < 0.5) {
        strProgress = @"40-50%";
    }else if (progress < 0.6) {
        strProgress = @"50-60%";
    }else if (progress < 0.7) {
        strProgress = @"60-70%";
    }else if (progress < 0.8) {
        strProgress = @"70-80%";
    }else if (progress < 0.9) {
        strProgress = @"80-90%";
    }else {
        strProgress = @"90-100%";
    }
    return strProgress;
}

+ (NSString *)getExportCostTimeStr:(unsigned long long)second {
    NSString *strCostTime;
    unsigned long long min = second / 60;
    if (min < 10) {
        strCostTime = [NSString stringWithFormat:@"%llumin",min];
    }else if (min<20) {
        strCostTime = @"10-20min";
    }else {
        strCostTime = @">20min";
    }
    return strCostTime;
}

@end
