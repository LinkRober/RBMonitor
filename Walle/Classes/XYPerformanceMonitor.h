//
//  XYPerformanceMonitor.h
//  Pods
//
//  Created by hongru qi on 04/07/2017.
//
//

#import <Foundation/Foundation.h>

/**
 性能分析，输出每秒中，帧率，内存，CPU 使用情况。
 log以输入到文件内Library／Caches／Logs 目录下
 同时支持显示到，App status bar 上，测试过程中可以，直接看到性能数据。
 */
@interface XYPerformanceMonitor : NSObject

+ (instancetype)sharedInstance;

- (void)startMonitorWithBar:(BOOL)isShownPerformanceBar;

/**
 默认关闭显示 帧率，内存，CPU的view
 启动性能监控，主线程卡顿timeout时间 = perTimeout * timeOutCount
 
 @param perTimeout 主线程单次执行的timeout时间。默认值为50。设置为0时，使用默认值
 @param timeOutCount timeout次数。 默认值为5。设置为0时，使用默认值
 */
- (void)startMonitor:(NSInteger)perTimeout mainLoopTimeoutCount:(NSInteger)timeOutCount;

- (void)stop;

- (void)setPageName:(NSString *)name;

@end
