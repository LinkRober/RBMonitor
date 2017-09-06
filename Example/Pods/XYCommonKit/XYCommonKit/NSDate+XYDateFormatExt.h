//
//  NSDate+XYDateExt.h
//  XiaoYing
//
//  Created by hongru qi on 2016/12/14.
//  Copyright © 2016年 XiaoYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XYDateFormatExt)
/**
 Get a formatted date  eg.@"yyyy-MM-dd HH:mm:ss"
 @param dateStr  The NSString that will be converted to a NSDate with the format
 */
+ (NSDate *)xy_dateFromFormatString:(NSString *)dateStr;
/**
 Get a formatted date  eg.@"yyyyMMddHHmmss"
 @param dateString  The NSString that will be converted to a NSDate with the format
 */
+ (NSDate *)xy_dateFromString:(NSString *)dateString;
/**
 Get a formatted string @"yyyy-MM-dd HH:mm:ss"
 */
+ (NSString *)xy_stringFromDate:(NSDate *)date;

/**
 Get a formatted date  eg.@"yyyyMMddHHmmss"
 @param dateString  The NSString that will be converted to a NSDate with the format
 @param timeZoneString  The date format with tiemzone.
 */
+ (NSDate *)xy_dateFromString:(NSString *)dateString timeZoneString:(NSString *)timeZoneString;
/**
 Get a formatted date
 @param dateString  The NSString that will be converted to a NSDate with the format
 @param format  The date format with format.
 */
+ (NSDate *)xy_dateFromString:(NSString *)dateString withFormat:(NSString *)format;

+ (NSString *)xy_stringFromDate:(NSDate *)date withFormat:(NSString *)string;
/**
 yyyy年MM月dd日
 
 @param time time stamp
 @return time formate string
 */
+ (NSString *)xy_getYMDChineseFormate:(long long)time;
/**
 t<1min 刚刚
 t<1h 几分钟前
 1h<t<24h  多少小时前
 1d<t<30d  多少天前
 t>30d  03-20
 
 @param publishTime time stamp
 @return time formate string
 */
+ (NSString *)xy_getTmeSlotFormate:(long long )publishTime;

/**
 Convert time to long long
 */
+ (long long)xy_currentMilliseconds;
/**
 Convert time to long long
 @param dateString  The NSString that will be converted to a long long
 */
+(long long)xy_longlongDateFromString:(NSString*)dateString;

+(BOOL)xy_isToday:(NSDate*)date;

- (NSUInteger)xy_daysAgo;

- (NSUInteger)xy_daysAgoAgainstMidnight;

- (NSString *)xy_stringDaysAgo;

- (NSString *)xy_stringDaysAgoAgainstMidnight:(BOOL)flag;

+ (NSString *)xy_timeWithTimeIntervalString:(NSString *)timeString;

- (NSUInteger)xy_weekday;

+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date;
+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime;

- (NSString *)xy_string;
- (NSString *)xy_stringWithFormat:(NSString *)format;
- (NSString *)xy_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDate *)xy_beginningOfWeek;
- (NSDate *)xy_beginningOfDay;
- (NSDate *)xy_endOfWeek;

+ (NSInteger)xy_latterHoursThanDate:(NSDate*)date;

@end
