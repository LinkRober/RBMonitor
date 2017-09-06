//
//  NSString+AppInfo.h
//  Pods
//
//  Created by hongru qi on 2017/2/24.
//
//

#import <Foundation/Foundation.h>

@interface NSString (AppInfo)

+ (NSString *)xy_getAppName;

+ (NSString *)xy_getAppVersion;

+ (NSString *)xy_getAppBuildVersion;

+ (NSString *)xy_getAppKey;

+ (NSString *)xy_getWecycleBaseUrl;

@end
