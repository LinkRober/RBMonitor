//
//  XYDeviceUtils.h
//  XiaoYing
//
//  Created by xuxinyuan on 13-4-28.
//  Copyright (c) 2013年 XiaoYing Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYDeviceUtility : NSObject

+ (NSString *)openUDID;
+ (NSString *)advertisingIdentifier;
+ (NSString *)localizedModel;
+ (NSString *)systemVersion;
+ (NSString *)systemName;
+ (NSString *)fullSystemName;
+ (NSString *)model;
+ (NSString *)fullModel;
+ (NSString *)language;
+ (NSString *)umuid;
+ (NSString *)xiaoyingID;
+ (NSString *)cellularProviderName;
+ (NSString *)getReadableDeviceName;
+ (long long)freeDiskSpaceInBytes;
+ (NSString *)fullLanguage;
//+ (NSString *)fullLanguageWithCountry;
+ (NSString *)pushLanguage;
//+ (NSString *)countryCode;
+ (BOOL)is64bit;
+ (NSString *)getXiaoYingAppKey;
+ (int)getAppKeyVersionCode;
+ (BOOL)isEqualOrThan5s;
+ (BOOL)isDiskSpaceEnoughForExporting:(unsigned int)fileSize;
+ (BOOL)isTestVersion;
+ (BOOL)isChinese;
+ (BOOL)isHaveEnoughDiskSpace;
+ (BOOL)isPerformanceEqualOrGreaterThan5s;
+ (NSDictionary *)deviceInfo;
@end
