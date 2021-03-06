//
//  XYPerformanceMonitor.m
//  Pods
//
//  Created by hongru qi on 04/07/2017.
//
//

#import "XYPerformanceMonitor.h"
#import "XYPerformanceUtility.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "DDLegacyMacros.h"
#import "XYPerformanceView.h"
#import "XYPerformanceLabel.h"
#include <mach/mach_time.h>
#import "UIViewController+Performance.h"
#import "XYMainLoopMonitor.h"
#import "XYCommonKit.h"
#import "AFNetworking.h"

static const DDLogLevel ddLogLevel = DDLogLevelInfo;
static uint64_t loadTime;
static uint64_t applicationRespondedTime = -1;
static mach_timebase_info_data_t timebaseInfo;
static NSMutableArray<Class> *URLProtocols;

static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer) / timebaseInfo.denom;
}

@interface XYPerformanceMonitor()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) XYPerformanceView *performanceView;
@property (nonatomic, assign) BOOL isShownPerformanceBar;
@property (nonatomic, copy) NSString *currentPageName;
@property (nonatomic, strong) AFHTTPSessionManager *afSessionManager;

@end

@implementation XYPerformanceMonitor

+ (void)load
{
    loadTime = mach_absolute_time();
    mach_timebase_info(&timebaseInfo);
    NSString *realAppKey = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"XiaoYingAppKey"];
    NSString *strChannel = [realAppKey substringWithRange:NSMakeRange(6, 2)];

    if ([strChannel isEqualToString:@"TS"]) {
        @autoreleasepool {
            __block id obs;
            obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                                    object:nil queue:nil
                                                                usingBlock:^(NSNotification *note) {
                                                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                                                        applicationRespondedTime = mach_absolute_time();
                                                                        DDLogInfo(@"VivaVideo_iOS_Launch_Time: %.f", MachTimeToSeconds(applicationRespondedTime - loadTime));
                                                                    });
                                                                    [[NSNotificationCenter defaultCenter] removeObserver:obs];
                                                                }];
        }
    }

}

#pragma mark - Init
+ (instancetype)sharedInstance{
    static XYPerformanceMonitor * sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XYPerformanceMonitor alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(envokeDisplayLink:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _displayLink.paused = YES;
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        [DDLog addLogger:fileLogger];
        if (fileLogger.currentLogFileInfo.fileSize < 4*1024) {
            NSString *deviceName = [XYDeviceUtility getReadableDeviceName];
            NSString *system = [XYDeviceUtility systemVersion];
            NSString *systemName = [XYDeviceUtility systemName];
            DDLogInfo(@"device:%@,%@:%@",deviceName,systemName,system);
        }
        _performanceView = [[XYPerformanceView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    }
    
    return self;
}

- (void)dealloc
{
    _displayLink.paused = YES;
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)startMonitorWithBar:(BOOL)isShownPerformanceBar
{
    self.displayLink.paused = NO;
    [self.performanceView showPerformacneView:isShownPerformanceBar];
    [[XYMainLoopMonitor sharedInstance] startMonitor];
    [UIViewController startPerformanceMonitor];
}

- (void)startMonitor:(NSInteger)perTimeout mainLoopTimeoutCount:(NSInteger)timeOutCount
{
    self.displayLink.paused = NO;
    [self.performanceView showPerformacneView:NO];
    [[XYMainLoopMonitor sharedInstance] startMonitor:perTimeout count:timeOutCount];
    [UIViewController startPerformanceMonitor];
}

- (void)stop
{
    self.displayLink.paused = YES;
    [self.performanceView showPerformacneView:NO];
    [[XYMainLoopMonitor sharedInstance] endMonitor];
}

- (void)setPageName:(NSString *)name
{
    self.currentPageName = name;
}

- (void)envokeDisplayLink:(CADisplayLink *)displayLink
{
    if (_lastTime == 0) {
        _lastTime = displayLink.timestamp;
        return;
    }
    
    _count ++;
    
    NSTimeInterval interval = displayLink.timestamp - _lastTime;
    
    if (interval < 1) {
        return;
    }
    
    _lastTime = displayLink.timestamp;
    CGFloat fps = _count / interval;
    _count = 0;
    
    NSInteger shownFPS = round(fps);
    CGFloat memory = [XYPerformanceUtility usedMemoryInMB];
    CGFloat cpu = [XYPerformanceUtility cpuUsage];
    DDLogInfo(@"CurrentPage:%@,FPS:%ld,MEM:%.2f,CPU:%.2f", self.currentPageName, (long)shownFPS, memory, cpu);
    [self.performanceView setPerformanceViewData:cpu memory:memory FPS:shownFPS];
    
}

- (void)applicationDidBecomeActiveNotification {
    _displayLink.paused = NO;
}

- (void)applicationWillResignActiveNotification {
    _displayLink.paused = YES;
}



@end
