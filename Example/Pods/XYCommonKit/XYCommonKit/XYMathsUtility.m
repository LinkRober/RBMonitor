//
//  XYMathsUtility.m
//  Pods
//
//  Created by hongru qi on 2017/5/3.
//
//

#import "XYMathsUtility.h"

@implementation XYMathsUtility

+ (BOOL)isTwoFloatEqual:(float)float1 float2:(float)float2
{
    return fabsf(float1 - float2) < 1.0e-7;
}

+ (int)formatVideoDuration:(NSString *) strDuration
{
    int nDuration = 0;
    if (strDuration == nil || strDuration.length == 0) {
        nDuration = 0;
    }else if (strDuration.length == 5){
        //00:00
        //- (NSString *)substringWithRange:(NSRange)range;
        NSString* strMin = [strDuration substringWithRange: NSMakeRange(0, 2)];
        NSString* strSec = [strDuration substringWithRange: NSMakeRange(3, 2)];
        int min = [strMin intValue];
        int sec = [strSec intValue];
        nDuration = min * 60 + sec;
    }else if (strDuration.length == 8){
        //00:00:00
        NSString* strHour = [strDuration substringWithRange: NSMakeRange(0, 2)];
        NSString* strMin = [strDuration substringWithRange: NSMakeRange(3, 2)];
        NSString* strSec = [strDuration substringWithRange: NSMakeRange(6, 2)];
        int hour = [strHour intValue];
        int min = [strMin intValue];
        int sec = [strSec intValue];
        nDuration = hour * 60 * 60 + min * 60 + sec;
    }
    return nDuration;
}

+ (int)getPageCount:(int)totalCount pageSize:(int)pageSize
{
    if (totalCount <= 0 || pageSize <= 0) {
        return 0;
    }
    int pageCount = totalCount/pageSize;
    int lastPageCount = totalCount % pageSize;
    if (lastPageCount > 0) {
        pageCount ++;
    }
    return pageCount;
}

+ (BOOL)isRectHasNAN:(CGRect)rect
{
    return isnan(rect.origin.x)||isnan(rect.origin.y)||isnan(rect.size.width)||isnan(rect.size.height);
}

@end
