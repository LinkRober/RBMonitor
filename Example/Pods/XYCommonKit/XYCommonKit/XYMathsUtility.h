//
//  XYMathsUtility.h
//  Pods
//
//  Created by hongru qi on 2017/5/3.
//
//

#import <Foundation/Foundation.h>

@interface XYMathsUtility : NSObject

+ (BOOL)isTwoFloatEqual:(float)float1 float2:(float)float2;

+ (int)formatVideoDuration:(NSString *)strDuration;

+ (int)getPageCount:(int)totalCount pageSize:(int)pageSize;

+ (BOOL)isRectHasNAN:(CGRect)rect;

@end
