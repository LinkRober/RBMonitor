//
//  XYUserBehaviorLog.m
//  XiaoYingSDK
//
//  Created by ShouHangjun on 12/3/14.
//  Copyright (c) 2014 XiaoYing. All rights reserved.
//

#import "XYUserLog.h"
#import "NSString+XYDateStringExt.h"


@interface XYUserLog()
{
    BOOL isTSChannel;
}

@end


@implementation XYUserLog

+ (instancetype) getLogInstance{
    static XYUserLog* sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[XYUserLog alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *realAppKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XiaoYingAppKey"];
        NSString *channel = [realAppKey substringWithRange:NSMakeRange(6, 2)];
        if ([channel isEqualToString:@"TS"]) {
            isTSChannel = YES;
        }
    }
    return self;
}

#pragma mark -- Ali update user account

- (void)saveUserbehaviorLogFile:(NSString *)eventId params:(NSDictionary *)params {
    if (isTSChannel) {//如果是TS渠道的包，会在/Library/Caches/Logs目录下生成埋点日志文件，以供QA和PM进行确认
        NSString *paramsString = nil;
        if (params && [params isKindOfClass:[NSDictionary class]] && [params count]>0) {
            paramsString = [params description];//NSDictionary的description是NSUTF8StringEncoding的，会乱码，需要进行转换
            if (![NSString xy_isEmptyString:paramsString]) {
                paramsString = [NSString stringWithCString:[paramsString cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
            }
        }
        NSString *userBehaviorLog = [NSString stringWithFormat:@"【埋点】事件名 = %@\n参数列表 = %@\n\n",eventId,paramsString];
//        DDLogWarn(@"%@",userBehaviorLog);
    }
}

@end
