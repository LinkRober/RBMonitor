//
//  NSDate+XYDateExt.m
//  XiaoYing
//
//  Created by hongru qi on 2016/12/14.
//  Copyright © 2016年 XiaoYing. All rights reserved.
//

#import "NSDate+XYDateFormatExt.h"
#import "NSString+XYDateStringExt.h"
#import "XYDateFormatUtility.h"

@implementation NSDate (XYDateFormatExt)

+ (NSDate *)xy_dateFromFormatString:(NSString *)dateStr
{
    if ([NSString xy_isEmptyString:dateStr]) {
        return nil;
    }
    
    if ([dateStr length]<19) {
        return nil;
    }
    
    dateStr=[dateStr substringToIndex:19];
    // 2012-05-17 11:23:23
    NSDateFormatter *format = [XYDateFormatUtility formatterFormString:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromatdate = [format dateFromString:dateStr];
    return fromatdate;
}

+ (NSDate *)xy_dateFromString:(NSString *)dateString
{
    NSDateFormatter *format = [XYDateFormatUtility formatterFormString:@"yyyyMMddHHmmss"];
    NSDate *fromdate = [format dateFromString:dateString];
    return fromdate;
}

+ (NSString *)xy_stringFromDate:(NSDate *)date {
    return [date xy_stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)xy_dateFromString:(NSString *)dateString timeZoneString:(NSString *)timeZoneString
{
    NSDateFormatter *format = [XYDateFormatUtility formatterFormString:@"yyyyMMddHHmmss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:timeZoneString];
    [format setTimeZone:timeZone];
    NSDate *fromdate=[format dateFromString:dateString];
    return fromdate;
}

+ (long long)xy_currentMilliseconds
{
    return [[NSDate date] timeIntervalSince1970]*1000;
}

+(long long)xy_longlongDateFromString:(NSString*)dateString
{
    if ([NSString xy_isEmptyString:dateString]) {
        return 0;
    }
    
    NSDateFormatter *format = [XYDateFormatUtility formatterFormString:@"yyyyMMddHHmmss"];
    NSDate *fromdate=[format dateFromString:dateString];
    long long llFromDate = [fromdate timeIntervalSince1970]*1000;
    return llFromDate;
}

+(BOOL)xy_isToday:(NSDate*)date
{
    NSCalendarUnit unitFlags = (NSCalendarUnitYear |
                                NSCalendarUnitMonth |
                                NSCalendarUnitDay |
                                NSCalendarUnitWeekOfMonth |
                                NSCalendarUnitHour |
                                NSCalendarUnitMinute |
                                NSCalendarUnitSecond |
                                NSCalendarUnitWeekday |
                                NSCalendarUnitWeekdayOrdinal);
    
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:unitFlags fromDate:[NSDate date]];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (NSUInteger)xy_daysAgo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

- (NSUInteger)xy_daysAgoAgainstMidnight
{
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [XYDateFormatUtility formatterFormString:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];

    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)xy_stringDaysAgo
{
    return [self xy_stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)xy_stringDaysAgoAgainstMidnight:(BOOL)flag
{
    NSUInteger daysAgo = (flag) ? [self xy_daysAgoAgainstMidnight] : [self xy_daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
        	text = [NSString stringWithFormat:@"%lu days ago", (unsigned long)daysAgo];
    }
    return text;
}

- (NSUInteger)xy_weekday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSCalendarUnitWeekday) fromDate:self];
    return [weekdayComponents weekday];
}

//timestampFormatString yyyy-MM-dd HH:mm:ss
+ (NSDate *)xy_timestampFormatString:(NSString *)string
{
    NSDateFormatter *inputFormatter = [XYDateFormatUtility formatterFormString:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSDate *)xy_dateFromString:(NSString *)dateString withFormat:(NSString *)format
{
    NSDateFormatter *inputFormatter = [XYDateFormatUtility formatterFormString:format];
    NSDate *date = [inputFormatter dateFromString:dateString];
    return date;
}

- (NSString *)xy_stringWithFormat:(NSString *)format
{
    NSDateFormatter *outputFormatter = [XYDateFormatUtility formatterFormString:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

+ (NSString *)xy_stringFromDate:(NSDate *)date withFormat:(NSString *)format {
    return [date xy_stringWithFormat:format];
}


+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *displayFormatter;
    
    NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    NSString *displayString = nil;
    
    // comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
    if (midnight_result == NSOrderedDescending) {
        if (prefixed) {
            displayFormatter = [XYDateFormatUtility formatterFormString:@"'at' h:mm a"];// at 11:30 am
        } else {
            displayFormatter = [XYDateFormatUtility formatterFormString:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        //[componentsToSubtract release];
        NSComparisonResult lastweek_result = [date compare:lastweek];
        if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                displayFormatter = [XYDateFormatUtility formatterFormString:@"EEEE h:mm a"];
            } else {
                displayFormatter = [XYDateFormatUtility formatterFormString:@"EEEE"]; // Tuesday
            }
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                if (displayTime) {
                    displayFormatter = [XYDateFormatUtility formatterFormString:@"MMM d h:mm a"];
                }
                else {
                    displayFormatter = [XYDateFormatUtility formatterFormString:@"MMM d"];
                }
            } else {
                if (displayTime) {
                    displayFormatter = [XYDateFormatUtility formatterFormString:@"MMM d, yyyy h:mm a"];
                }
                else {
                    displayFormatter = [XYDateFormatUtility formatterFormString:@"MMM d, yyyy"];
                }
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    
    // [displayFormatter release];
    
    return displayString;
}

+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed
{
    return [self xy_stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

+ (NSString *)xy_stringForDisplayFromDate:(NSDate *)date
{
    return [self xy_stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)xy_string
{
    return [NSDate xy_stringFromDate:self];
}

- (NSString *)xy_stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}

- (NSDate *)xy_beginningOfWeek
{
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekOfMonth fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}

- (NSDate *)xy_beginningOfDay
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}

- (NSDate *)xy_endOfWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return endOfWeek;
}

+ (NSString *)xy_getYMDChineseFormate:(long long)time {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(time/1000.0)];
    NSDateFormatter *formatter = [XYDateFormatUtility formatterFormString:@"yyyy年MM月dd日"];
    NSString *res = [formatter stringFromDate:date];
    return res;
}

+ (NSString *)xy_getTmeSlotFormate:(long long )publishTime{
    if (publishTime == 0) {
        return @"刚刚";
    }
    long long currentTime = [NSDate xy_currentMilliseconds];
    
    long long interval = (currentTime - publishTime)/1000;
    
    NSString* formatedStr;
    if (interval < 60) {
        formatedStr = @"刚刚";
    }else if (interval < 60*60){
        int minute = (int)interval/60;
        formatedStr = [NSString stringWithFormat:@"%d分钟前",minute];
    }else if (interval < 60*60*24){
        int hour = (int)interval/(60*60);
        formatedStr = [NSString stringWithFormat:@"%d小时前",hour];
    }else if (interval <60*60*24*7){
        int day = (int)interval/(60*60*24);
        formatedStr = [NSString stringWithFormat:@"%d天前",day];
    }else {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSCalendarUnit type = NSCalendarUnitYear |
        NSCalendarUnitMonth |
        NSCalendarUnitDay |
        NSCalendarUnitHour |
        NSCalendarUnitMinute |
        NSCalendarUnitSecond;
        // 4.获取了时间元素
        NSDateComponents *cmps = [calendar components:type fromDate:date toDate:now options:0];
        return [NSString stringWithFormat:@"%ld-%ld",(long)cmps.month,(long)cmps.day];
    }
    return formatedStr;
}

+ (NSString *)xy_timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [XYDateFormatUtility formatterFormString:@"yyyyMMddHHmmss"];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSInteger)xy_latterHoursThanDate:(NSDate*)date
{
    //得到与当前时间差
    NSTimeInterval before = [date timeIntervalSince1970];
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval cha = now - before;
    
    NSInteger result = cha/3600;
    
    NSLog(@"latterHoursThanDate %ld ", (long)result);
    
    if (result < 0) {
        result = 0;
    }
    
    return result;
}


@end
