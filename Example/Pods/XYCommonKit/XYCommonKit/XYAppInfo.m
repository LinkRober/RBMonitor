//
//  XYAppInfo.m
//  Pods
//
//  Created by hongru qi on 2017/5/20.
//
//

#import "XYAppInfo.h"

@implementation XYAppInfo

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
