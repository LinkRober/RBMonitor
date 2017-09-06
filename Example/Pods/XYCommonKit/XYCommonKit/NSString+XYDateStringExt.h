//
//  NSString+XYDateStringExt.h
//  XiaoYing
//
//  Created by hongru qi on 2016/12/14.
//  Copyright © 2016年 XiaoYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYDateStringExt)

+ (NSString *)xy_getDateStringWithFormat:(NSString *)format date:(NSDate *)date;

/**
 Get a EN locale formatted date string
 @param format  The date format for the receiver. eg.@"yyyyMMdd hhmmss"
 @param date   The NSDate that will be converted to a NSString with the format above
 */
+ (NSString *)xy_getDateStringWithEnFormat:(NSString *)format date:(NSDate *)date;

/**
 Get a formatted date string
 @param format  The date format for the receiver. eg.@"yyyyMMdd hhmmss"
 @param date   The NSDate that will be converted to a NSString with the format above
 @param language  Use the language string to get locale , then set it to the dateformat
 */
+ (NSString *)xy_getDateStringWithFormat:(NSString *)format date:(NSDate *)date language:(NSString *)language;

+ (NSDate *)xy_getDateFromFormatString:(NSString *)dateStr;

/**
 Returns YES if the string is nil or equal to @""
 */
+ (BOOL)xy_isEmptyString:(NSString *)string;
/**
 The NSString eg:yyyyMMddHHmmss  that will be converted to a string eg.yyyy/MM/dd with the format
 @param dateString  a date string
 */
+ (NSString *)xy_formatMessageListDateString:(NSString *)dateString;

/**
 Returns YES or NO
 @param time1  time format:yyyyMMddHHmmss
 @param time2  time format:yyyyMMddHHmmss
 */
+ (BOOL)xy_checkTime:(NSString*)time1 earliertThan:(NSString*)time2;
/**
 Returns YES or NO
 @param expiredTime  time format:yyyyMMddHHmmss
 */
+ (BOOL)xy_checkTimeExpiredNow:(NSString*)expiredTime;
/**
 return YES, if lastUpdateTime is minInterval(second) before
 @param lastUpdateTime  time format:yyyyMMddHHmmss
 @param minInterval  time format:yyyyMMddHHmmss
 */
+ (BOOL)xy_checkIfNeedUpdateList:(NSString*)lastUpdateTime minInterval:(double)minInterval;

+ (NSString *)xy_stringFromMilliseconds:(UInt32)totalMilliseconds style:(NSString *)style;

+ (NSString *)xy_stringFromMilliseconds:(UInt32)totalMilliseconds;

+ (NSString *)xy_stringFromSeconds:(UInt32)totalSeconds;

+ (NSDictionary *)xy_dictionaryWithJsonString:(NSString *)jsonString;

@end
