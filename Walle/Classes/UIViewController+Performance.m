//
//  UIViewController+Performance.m
//  Pods
//
//  Created by hongru qi on 14/07/2017.
//
//

#import "UIViewController+Performance.h"
#import <objc/runtime.h>
#import <CocoaLumberjack/CocoaLumberjack.h>
#import "DDLegacyMacros.h"
#import "JRSwizzle.h"
#import "XYPerformanceMonitor.h"

static const DDLogLevel ddLogLevel = DDLogLevelInfo;

@interface UIViewController()

@property (nonatomic, assign) CFTimeInterval viewControllerAppearDuration;

@end

@implementation UIViewController (Performance)

+ (void)startPerformanceMonitor
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController jr_swizzleMethod:@selector(loadView) withMethod:@selector(walle_loadView) error:nil];
        [UIViewController jr_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(walle_viewDidLoad) error:nil];
        [UIViewController jr_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(walle_viewWillAppear:) error:nil];
        [UIViewController jr_swizzleMethod:@selector(viewDidAppear:) withMethod:@selector(walle_viewDidAppear:) error:nil];
    });
}

- (void)walle_loadView
{
    self.viewControllerAppearDuration =  CACurrentMediaTime();
    [self walle_loadView];
//    DDLogInfo(@"PageInitTime %@ %@ :%g", NSStringFromClass(self.class), NSStringFromSelector(_cmd), CACurrentMediaTime() - start);
}

- (void)walle_viewDidLoad
{
//    CFTimeInterval start =  CACurrentMediaTime();
    [self walle_viewDidLoad];
//    DDLogInfo(@"PageInitTime %@ %@ :%g", NSStringFromClass(self.class), NSStringFromSelector(_cmd), CACurrentMediaTime() - start);
}

- (void)walle_viewWillAppear:(BOOL)animated
{
//    CFTimeInterval start =  CACurrentMediaTime();
    if (self.viewControllerAppearDuration == 0) {
        self.viewControllerAppearDuration = CACurrentMediaTime();
    }
    
    [self walle_viewWillAppear:animated];
//    DDLogInfo(@"PageInitTime %@ %@ :%g", NSStringFromClass(self.class), NSStringFromSelector(_cmd), CACurrentMediaTime() - start);
}

- (void)walle_viewDidAppear:(BOOL)animated
{
//    CFTimeInterval start =  CACurrentMediaTime();
    [self walle_viewDidAppear:animated];
//    DDLogInfo(@"PageInitTime %@ %@ :%g", NSStringFromClass(self.class), NSStringFromSelector(_cmd), CACurrentMediaTime() - start);
    
    self.viewControllerAppearDuration = CACurrentMediaTime() - self.viewControllerAppearDuration;
    NSString *name = NSStringFromClass(self.class);
    DDLogInfo(@"PageInitTime %@:%g", name, self.viewControllerAppearDuration);
    self.viewControllerAppearDuration = 0;
    [[XYPerformanceMonitor sharedInstance] setPageName:NSStringFromClass(self.class)];
}

- (void)setViewControllerAppearDuration:(CFTimeInterval)viewControllerAppearDuration
{
    objc_setAssociatedObject(self, @selector(viewControllerAppearDuration), @(viewControllerAppearDuration), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CFTimeInterval )viewControllerAppearDuration
{
    return [objc_getAssociatedObject(self, @selector(viewControllerAppearDuration)) doubleValue];
}

@end
