//
//  XYDeviceUtils.m
//  XiaoYing
//
//  Created by xuxinyuan on 13-4-28.
//  Copyright (c) 2013年 XiaoYing Team. All rights reserved.
//

#import "XYDeviceUtility.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "OpenUDID.h"
#import "XYPreference.h"
#import "NSString+XYDateStringExt.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include "stdlib.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <sys/param.h>
#include <sys/mount.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <AdSupport/AdSupport.h>

@implementation XYDeviceUtility

+ (NSString *)openUDID
{
    return [OpenUDID value];
}

+ (NSString *)xiaoyingID
{
    return [NSString stringWithFormat:@"[I]%@",[OpenUDID value]];
}

+ (NSString *)advertisingIdentifier
{
    NSString * advertisingIdentifier = @"";
    if(NSClassFromString(@"ASIdentifierManager")){
        advertisingIdentifier= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    
    return advertisingIdentifier;
}

+ (NSString *)localizedModel
{
    return [[UIDevice currentDevice] localizedModel];
}

+ (NSString *) systemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *) systemName
{
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *) fullSystemName
{
    return [NSString stringWithFormat:@"%@%@",[self systemName],[self systemVersion]];
}

+ (NSString *) model
{
    return [[UIDevice currentDevice] model];
}

+ (NSString *) fullModel
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char* machine = (char*)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

//    zh-Hans,
//    zh-Hant,
//    en,
//    fr,
//    de,
//    ja,
//    nl,
//    it,
//    es,
//    es-MX,
//    ko,
//    pt,
//    pt-PT,
//    da,
//    fi,
//    nb,
//    sv,
//    ru,
//    pl,
//    tr,
//    uk,
//    ar,
//    hr,
//    cs,
//    el,
//    he,
//    ro,
//    sk,
//    th,
//    id,
//    ms,
//    en-GB,
//    en-AU,
//    ca,
//    hu,
//    vi
+ (NSString *) language
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
//    NSLog(@"Preferred Language:%@", preferredLang);
    if(preferredLang && [self isSameLanguageKind:@"zh-Hans" lang:preferredLang]) {
        preferredLang = @"zh_CN";
    }else if(preferredLang && [self isSameLanguageKind:@"zh-Hant" lang:preferredLang]) {
        preferredLang = @"zh_TW";
    }else{
        preferredLang = @"en";
    }
    return preferredLang;
}

+ (NSString *) fullLanguage{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if(preferredLang && [self isSameLanguageKind:@"zh-Hans" lang:preferredLang]) {
        preferredLang = @"zh_CN";
    }
    else if(preferredLang &&  [self isSameLanguageKind:@"zh-Hant" lang:preferredLang]) {
        preferredLang = @"zh_TW";
    }
    else if(preferredLang && [self isSameLanguageKind:@"de" lang:preferredLang]) {
        preferredLang = @"de";
    }
    else if(preferredLang && [self isSameLanguageKind:@"es" lang:preferredLang]) {
        preferredLang = @"es";
    }
    else if(preferredLang && [self isSameLanguageKind:@"fr" lang:preferredLang]) {
        preferredLang = @"fr";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ja" lang:preferredLang]) {
        preferredLang = @"ja";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ko" lang:preferredLang]) {
        preferredLang = @"ko";
    }
    else if(preferredLang && [self isSameLanguageKind:@"pt" lang:preferredLang]) {
        preferredLang = @"pt";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ru" lang:preferredLang]) {
        preferredLang = @"ru";
    }
    else if(preferredLang && [self isSameLanguageKind:@"id" lang:preferredLang]) {
        preferredLang = @"in";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ms" lang:preferredLang]) {
        preferredLang = @"ms";
    }
    else if(preferredLang && [self isSameLanguageKind:@"th" lang:preferredLang]) {
        preferredLang = @"th";
    }
    else if(preferredLang && [self isSameLanguageKind:@"vi" lang:preferredLang]) {
        preferredLang = @"vi";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ar" lang:preferredLang]) {
        preferredLang = @"ar";
    }
    else if(preferredLang && [self isSameLanguageKind:@"it" lang:preferredLang]) {
        preferredLang = @"it";
    }
    else if(preferredLang && [self isSameLanguageKind:@"tr" lang:preferredLang]) {
        preferredLang = @"tr";
    }
    
    else{
        preferredLang = @"en";
    }
    return preferredLang;
}

+ (NSString *)pushLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if(preferredLang && [self isSameLanguageKind:@"zh-Hans" lang:preferredLang]) {
        preferredLang = @"zh";
    }
    else if(preferredLang &&  [self isSameLanguageKind:@"zh-Hant" lang:preferredLang]) {
        preferredLang = @"zh";
    }
    else if(preferredLang &&  [self isSameLanguageKind:@"zh-HK" lang:preferredLang]) {
        preferredLang = @"zh";
    }
    else if(preferredLang &&  [self isSameLanguageKind:@"zh-TW" lang:preferredLang]) {
        preferredLang = @"zh";
    }
    else if(preferredLang && [self isSameLanguageKind:@"de" lang:preferredLang]) {
        preferredLang = @"de";
    }
    else if(preferredLang && [self isSameLanguageKind:@"es" lang:preferredLang]) {
        preferredLang = @"es";
    }
    else if(preferredLang && [self isSameLanguageKind:@"fr" lang:preferredLang]) {
        preferredLang = @"fr";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ja" lang:preferredLang]) {
        preferredLang = @"ja";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ko" lang:preferredLang]) {
        preferredLang = @"ko";
    }
    else if(preferredLang && [self isSameLanguageKind:@"pt" lang:preferredLang]) {
        preferredLang = @"pt";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ru" lang:preferredLang]) {
        preferredLang = @"ru";
    }
    else if(preferredLang && [self isSameLanguageKind:@"id" lang:preferredLang]) {
        preferredLang = @"in";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ms" lang:preferredLang]) {
        preferredLang = @"ms";
    }
    else if(preferredLang && [self isSameLanguageKind:@"th" lang:preferredLang]) {
        preferredLang = @"th";
    }
    else if(preferredLang && [self isSameLanguageKind:@"vi" lang:preferredLang]) {
        preferredLang = @"vi";
    }
    else if(preferredLang && [self isSameLanguageKind:@"ar" lang:preferredLang]) {
        preferredLang = @"ar";
    }
    else if(preferredLang && [self isSameLanguageKind:@"it" lang:preferredLang]) {
        preferredLang = @"it";
    }
    else if(preferredLang && [self isSameLanguageKind:@"tr" lang:preferredLang]) {
        preferredLang = @"tr";
    }
    else{
        preferredLang = @"en";
    }
    return preferredLang;
}

+ (NSString *)fullLanguageWithCountry
{
    //TODO
    NSString *strLang = [self pushLanguage];
    NSString *strCountry = [self countryCode]; //[[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSString *strLangCountry = [NSString stringWithFormat:@"%@_%@", strLang, strCountry];
    return strLangCountry;
}

+ (NSString *)countryCode
{
    NSString *strCountry = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    return strCountry;
}

+ (BOOL)isSameLanguageKind:(NSString*)lang lang:(NSString*)preferredLang
{
    if (preferredLang == nil || lang == nil) {
        return FALSE;
    }
    
    if ([preferredLang isEqualToString:lang]) {
        return TRUE;
    }
    
    NSString* langPrefix = [NSString stringWithFormat:@"%@-",lang];
    if ([preferredLang hasPrefix:langPrefix]) {
        return TRUE;
    }
    
    return FALSE;
}


+ (NSString *)umuid
{
    NSString *plistPath = [NSString stringWithFormat:@"%@/.UMSocialData.plist",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    return data[@"uid"];
}

+ (NSString *)cellularProviderName
{
    CTTelephonyNetworkInfo *netInfo = [[CTTelephonyNetworkInfo alloc]init];
    CTCarrier *carrier = [netInfo subscriberCellularProvider];
    NSString *cellularProviderName = [carrier carrierName];
    return cellularProviderName;
}

+ (NSString *)getReadableDeviceName
{
        NSString *platform = [self fullModel];
        if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1";
        if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3g";
        if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3gs";
        if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
        if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
        if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
        if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4s";
        if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
        if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
        if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
        if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
        if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
        if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
        if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
        if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
        if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
        if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
        if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
        if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
        if ([platform isEqualToString:@"iPod1,1"])      return @"iPod touch 1";
        if ([platform isEqualToString:@"iPod2,1"])      return @"iPod touch 2";
        if ([platform isEqualToString:@"iPod3,1"])      return @"iPod touch 3";
        if ([platform isEqualToString:@"iPod4,1"])      return @"iPod touch 4";
        if ([platform isEqualToString:@"iPod5,1"])      return @"iPod touch 5";
        if ([platform isEqualToString:@"iPod7,1"])      return @"iPod touch 7";
        if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
        if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";
        if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2";
        if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2";
        if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2";
        if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini";
        if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini";
        if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini";
        if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3";
        if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3";
        if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3";
        if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4";
        if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4";
        if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4";
        if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air";
        if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air";
        if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
        if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2";
        if ([platform isEqualToString:@"iPad4,6"])      return @"iPad mini 2";
        if ([platform isEqualToString:@"i386"])         return @"Simulator";
        if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
        return platform;
}



+ (long long)freeDiskSpaceInBytes
{
    struct statfs buf;
    long long freespace = -1;
    if(statfs("/var", &buf) >= 0){
        freespace = (long long)(buf.f_bsize * buf.f_bfree);
        freespace -= 240 * 1024 * 1024;
        freespace = (freespace<0)?0:freespace;
    }
    NSString *strFreeSpace = [NSString stringWithFormat:@"手机剩余存储空间为：%qi MB" ,freespace/1024/1024];
    NSLog(@"%@",strFreeSpace);
    return freespace;
}

+ (BOOL)is64bit
{
#if defined(__LP64__) && __LP64__
    return YES;
#else
    return NO;
#endif
}

+ (NSString *)getXiaoYingAppKey
{
    NSString *realAppKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XiaoYingAppKey"];
    if (![XYDeviceUtility isTestVersion]) {
        return realAppKey;
    }
    NSString *appKey = [XYPreference xy_loadEncryptPreference:@"KeyTestAppKey"];
    if ([NSString xy_isEmptyString:appKey]) {
        appKey = realAppKey;
    }
    return appKey;
}

+ (BOOL)isTestVersion
{
    NSString *realAppKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XiaoYingAppKey"];
    NSString *strChannel = [realAppKey substringWithRange:NSMakeRange(6, 2)];
    if ([strChannel isEqualToString:@"TS"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (int)getAppKeyVersionCode
{
    NSString *xiaoyingAppKey = [XYDeviceUtility getXiaoYingAppKey];
    NSString* subAppKey;
    if (xiaoyingAppKey.length >= 6) {
        subAppKey = [xiaoyingAppKey substringToIndex:6];
    }
    int nAppKey = [subAppKey intValue];
    return nAppKey;
}

+ (BOOL)isEqualOrThan5s {
    NSString *platform = [XYDeviceUtility fullModel];
    if([platform hasPrefix:@"iPhone"])
    {
        NSRange range = NSMakeRange(6, 1);
        NSString *flagStr = [platform substringWithRange:range];
        int flag = flagStr.intValue;
        if(flag >= 6)
        {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isHaveEnoughDiskSpace
{
    BOOL isEnough = YES;
    long long freeSpace = [self freeDiskSpaceInBytes];
    if (freeSpace == 0) {
        isEnough = NO;
    }
    
    return YES;
}

+ (BOOL)isChinese
{
    BOOL isChinese = NO;
    NSString *currentLanguage = [self language];
    if([currentLanguage isEqualToString:@"zh_CN"]
       ||[currentLanguage isEqualToString:@"zh_TW"]) {
        isChinese = YES;
    }
    return isChinese;
}

+ (BOOL)isDiskSpaceEnoughForExporting:(unsigned int)fileSize
{
    long long dwMaxFileSize = [XYDeviceUtility freeDiskSpaceInBytes]/2;
    return (dwMaxFileSize < fileSize)? NO:YES;
}

+ (BOOL)isPerformanceEqualOrGreaterThan5s
{
    NSString *platform = [self fullModel];
    if([platform hasPrefix:@"iPhone"]) {
        NSRange range = NSMakeRange(6, 1);
        NSString *flagStr = [platform substringWithRange:range];
        int flag = flagStr.intValue;
        if(flag >= 6)
        {
            return YES;
        }
    }else if ([platform hasPrefix:@"iPad"]) {
        NSRange range = NSMakeRange(4, 1);
        NSString *flagStr = [platform substringWithRange:range];
        int flag = flagStr.intValue;
        if(flag >= 4)
        {
            return YES;
        }
    }
    
    
    return NO;
}

+ (NSDictionary *)deviceInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[self openUDID] forKey:@"openUDID"];
    [dict setValue:[self advertisingIdentifier] forKey:@"advertisingIdentifier"];
    [dict setValue:[self localizedModel] forKey:@"localizedModel"];
    [dict setValue:[self systemVersion] forKey:@"systemVersion"];
    [dict setValue:[self systemName] forKey:@"systemName"];
    [dict setValue:[self fullSystemName]  forKey:@"fullSystemName"];
    [dict setValue:[self model] forKey:@"model"];
    [dict setValue:[self fullModel] forKey:@"fullModel"];
    [dict setValue:[self language] forKey:@"language"];
    [dict setValue:[self umuid] forKey:@"umuid"];
    [dict setValue:[self xiaoyingID] forKey:@"xiaoyingID"];
    [dict setValue:[self getReadableDeviceName] forKey:@"getReadableDeviceName"];
    [dict setValue:@([self freeDiskSpaceInBytes]) forKey:@"freeDiskSpaceInBytes"];
    [dict setValue:[self fullLanguage] forKey:@"fullLanguage"];
    [dict setValue:[self fullLanguageWithCountry] forKey:@"fullLanguageWithCountry"];
    [dict setValue:[self pushLanguage] forKey:@"pushLanguage"];
    [dict setValue:[self countryCode] forKey:@"countryCode"];
    [dict setValue:[self getXiaoYingAppKey] forKey:@"getXiaoYingAppKey"];
    return dict;
}
@end
