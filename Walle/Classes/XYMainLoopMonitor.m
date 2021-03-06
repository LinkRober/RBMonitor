//
//  XYMainMonitor.m
//  WeCycle
//
//  Created by Frenzy-Mac on 2017/5/19.
//  Copyright © 2017年 com.quvideo.wecycle. All rights reserved.
//

#import "XYMainLoopMonitor.h"
#import <libkern/OSAtomic.h>
#import <execinfo.h>
#import "BSBacktraceLogger.h"

@interface XYMainLoopMonitor(){
    CFRunLoopObserverRef _observer;
    dispatch_semaphore_t _semaphore;
    CFRunLoopActivity _activity;
    NSInteger _countTime;
}

@end

@implementation XYMainLoopMonitor

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)startMonitor
{
    [self registerObserverWithTimeOut:0 count:0];
}

- (void)startMonitor:(NSInteger)perTimeout count:(NSInteger)timeOutCount
{
    [self registerObserverWithTimeOut:perTimeout count:timeOutCount];
}

- (void)endMonitor
{
    if (_observer) {
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
        CFRelease(_observer);
        _observer = NULL;
    }
}

- (void)registerObserverWithTimeOut:(NSInteger)perTimeout count:(NSInteger)timeOutCount
{
    _observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        self->_activity = activity;
        dispatch_semaphore_t semaphore = self->_semaphore;
        dispatch_semaphore_signal(semaphore);
    });
    
    if (perTimeout <= 0) {
        perTimeout = 50;
    }
    
    if (timeOutCount <= 0) {
        timeOutCount = 5;
    }
    
    CFRunLoopAddObserver(CFRunLoopGetMain(), _observer, kCFRunLoopCommonModes);
    // 创建信号
    _semaphore = dispatch_semaphore_create(0);
    // 在子线程监控时长
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (YES)
        {
            // 超时250ms 认为卡顿
            long st = dispatch_semaphore_wait(_semaphore, dispatch_time(DISPATCH_TIME_NOW, perTimeout*NSEC_PER_MSEC));
            if (st != 0)
            {
                if (_activity == kCFRunLoopBeforeSources || _activity == kCFRunLoopAfterWaiting)
                {
                    if (++_countTime < timeOutCount)
                        continue;
                    NSString *track = [BSBacktraceLogger bs_backtraceOfMainThread];
                    NSLog(@"############### Main thread is blocked ###############");
                    NSLog(@"%@", track);
                    NSLog(@"############### Main thread is blocked ###############");
                }
            }
            _countTime = 0;
        }
    });
}


@end
