//
//  XYMainMonitor.h
//  WeCycle
//
//  Created by Frenzy-Mac on 2017/5/19.
//  Copyright © 2017年 com.quvideo.wecycle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYMainLoopMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitor;

- (void)startMonitor:(NSInteger)perTimeout count:(NSInteger)timeOutCount;

- (void)endMonitor;


@end
