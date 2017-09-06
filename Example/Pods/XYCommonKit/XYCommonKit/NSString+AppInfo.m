//
//  NSString+AppInfo.m
//  Pods
//
//  Created by hongru qi on 2017/2/24.
//
//

#import "NSString+AppInfo.h"

@implementation NSString (AppInfo)

+ (NSString *)xy_getAppName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)xy_getAppVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)xy_getAppBuildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)xy_getAppKey
{
    NSString* appkey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XiaoYingAppKey"];
    return appkey;
}

+ (NSString *)xy_getWecycleBaseUrl
{
    return @"http://wecycle-qa.api.xiaoying.co/";
}
@end
