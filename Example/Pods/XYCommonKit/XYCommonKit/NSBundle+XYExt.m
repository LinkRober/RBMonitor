//
//  NSBundle+XYExt.m
//  Pods
//
//  Created by hongru qi on 2017/1/19.
//
//

#import "NSBundle+XYExt.h"

@implementation NSBundle (XYExt)

+ (NSBundle *)xy_xiaoyingBundle
{
    NSString* mainBundlePath = [[self mainBundle] resourcePath];
    NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"XiaoYingResource.bundle"];
    return [self bundleWithPath:frameworkBundlePath];
}

@end
