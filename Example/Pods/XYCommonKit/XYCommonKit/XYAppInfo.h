//
//  XYAppInfo.h
//  Pods
//
//  Created by hongru qi on 2017/5/20.
//
//

#import <Foundation/Foundation.h>

@interface XYAppInfo : NSObject

+ (NSString *)xy_getAppName;

+ (NSString *)xy_getAppVersion;

+ (NSString *)xy_getAppBuildVersion;

+ (NSString *)xy_getAppKey;

+ (NSString *)xy_getWecycleBaseUrl;

@end
