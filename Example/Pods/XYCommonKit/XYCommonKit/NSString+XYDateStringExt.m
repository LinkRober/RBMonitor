//
//  NSString+XYStringExt.m
//  XiaoYing
//
//  Created by hongru qi on 2016/12/14.
//  Copyright © 2016年 XiaoYing. All rights reserved.
//

#import "NSString+XYDateStringExt.h"
#import "NSDate+XYDateFormatExt.h"
#import "XYDateFormatUtility.h"
@implementation NSString (XYStringExt)

+ (NSString *)xy_getDateStringWithFormat:(NSString *)format date:(NSDate *)date
{
    NSDateFormatter *formater = [XYDateFormatUtility formatterFormString:format];
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLocale *en_locale = [[NSLocale alloc] initWithLocaleIdentifier:preferredLang];
    [formater setLocale:en_locale];
    NSString *dateString = [formater stringFromDate:date];
    return dateString;
}

+ (NSString *)xy_getDateStringWithEnFormat:(NSString *)format date:(NSDate *)date
{
    return [self xy_getDateStringWithFormat:format date:date language:@"en"];
}

+ (NSString *)xy_getDateStringWithFormat:(NSString *)format date:(NSDate *)date language:(NSString *)language
{
    NSDateFormatter *formater = [XYDateFormatUtility formatterFormString:format];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:language];
    [formater setLocale:locale];
    NSString *dateString = [formater stringFromDate:date];
    return dateString;
}

+ (NSDate *)xy_getDateFromFormatString:(NSString *)dateStr
{
    if ([self xy_isEmptyString:dateStr]) {
        return nil;
    }
    if ([dateStr length]<19) {
        return nil;
    }
    dateStr=[dateStr substringToIndex:19];
    // 2012-05-17 11:23:23
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:dateStr];
    return fromdate;
}

+ (BOOL)xy_isEmptyString:(NSString *)string;
{
    // Note that [string length] == 0 can be false when [string isEqualToString:@""] is true, because these are Unicode strings.
    
    if (((NSNull *) string == [NSNull null]) || (string == nil) || ![string isKindOfClass:(NSString.class)]) {
        return YES;
    }
    
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)xy_formatMessageListDateString:(NSString *)dateString
{
    NSDateFormatter *format = [XYDateFormatUtility formatterFormString:@"yyyyMMddHHmmss"];
    NSDate *fromdate = [format dateFromString:dateString];
    [format setDateFormat:@"yyyy/MM/dd"];
    NSString * formatDateString = [format stringFromDate:fromdate];
    return formatDateString;
}

+(BOOL)xy_checkTime:(NSString*)time1 earliertThan:(NSString*)time2
{
    if ([self xy_isEmptyString:time1]) {
        return YES;
    }
    
    if ([self xy_isEmptyString:time2]) {
        return NO;
    }
    
    long long longTime1 = [time1 longLongValue];
    long long longTime2 = [time2 longLongValue];
    
    if (longTime1 < longTime2) {
        return YES;
    }else{
        return NO;
    }
}

+(BOOL)xy_checkTimeExpiredNow:(NSString*)expiredTime
{
    if ([self xy_isEmptyString:expiredTime] || [expiredTime length]!=14) {
        return NO;
    }
    
    NSString* currentTime = [self xy_getDateStringWithFormat:@"yyyyMMddHHmmss" date:[NSDate date]];
    return [self xy_checkTime:expiredTime earliertThan:currentTime];
}

+ (BOOL)xy_checkIfNeedUpdateList:(NSString*)lastUpdateTime  minInterval:(double)minInterval
{
    if([self xy_isEmptyString:lastUpdateTime]){
        return YES;
    }
    
    NSDate *currentDate = (NSDate *)[NSDate date];

    NSDate *lastUpdateDate = [NSDate xy_dateFromString:lastUpdateTime];
    
    if (lastUpdateDate == nil) {
        return YES;
    }
    
    NSTimeInterval interval = [currentDate timeIntervalSinceDate:lastUpdateDate];
    
    if(interval > minInterval){
        return YES;
    }
    return NO;
}

+ (NSString *)xy_stringFromMilliseconds:(UInt32)totalMilliseconds style:(NSString *)style
{
    //    NSLog(@"totalMilliseconds = %lld",totalMilliseconds);
    long long milliseconds = (totalMilliseconds % 1000 )/100;
    long long seconds = totalMilliseconds / 1000 % 60;
    long long minutes = (totalMilliseconds / 1000 / 60) % 60;
    long long hours = (totalMilliseconds / 1000 / 3600);
    
    if([style isEqualToString:@"hh:mm:ss.ms"]){
        if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds,milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"ss.ms"]){
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%02lli.%01lli",seconds,milliseconds];
        }else if(hours == 0){
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli", minutes, seconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"s.ms"]){
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%01lli.%01lli",seconds,milliseconds];
        }else if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds, milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"sss.ms"]){//use 60.0 instead of 1:00.0
        if(hours == 0 && minutes == 0){
            return [NSString stringWithFormat:@"%01lli.%01lli",seconds,milliseconds];
        }else if(hours == 0 && minutes == 1){
            seconds += 60;
            return [NSString stringWithFormat:@"%02lli.%01lli", seconds, milliseconds];
        }else if(hours == 0){
            return [NSString stringWithFormat:@"%01lli:%02lli.%01lli", minutes, seconds, milliseconds];
        }else{
            if(milliseconds>=5){
                seconds+=1;
                if(seconds == 60){
                    seconds = 0;
                    minutes+=1;
                    if(minutes == 60){
                        minutes = 0;
                        hours+=1;
                    }
                }
            }
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }else if([style isEqualToString:@"ss'ms\""]){
        //mm'ss''
        if(milliseconds>=5){
            seconds+=1;
            if(seconds == 60){
                seconds = 0;
                minutes+=1;
                if(minutes == 60){
                    minutes = 0;
                    hours+=1;
                }
            }
        }
        if(hours == 0){
            return [NSString stringWithFormat:@"%02lli'%02lli''", minutes, seconds];
        }else{
            return [NSString stringWithFormat:@"%01lli:%02lli'%02lli''", hours, minutes, seconds];
        }
    }else{
        //hh:mm:ss
        if(milliseconds>=5){
            seconds+=1;
            if(seconds == 60){
                seconds = 0;
                minutes+=1;
                if(minutes == 60){
                    minutes = 0;
                    hours+=1;
                }
            }
        }
        if(hours == 0){
            return [NSString stringWithFormat:@"%02lli:%02lli", minutes, seconds];
        }else{
            return [NSString stringWithFormat:@"%01lli:%02lli:%02lli", hours, minutes, seconds];
        }
    }
}

+ (NSString *)xy_stringFromMilliseconds:(UInt32)totalMilliseconds
{
    //    NSLog(@"totalMilliseconds = %lld",totalMilliseconds);
    long long milliseconds = (totalMilliseconds % 1000 )/100;
    long long seconds = totalMilliseconds / 1000 % 60;
    long long minutes = (totalMilliseconds / 1000 / 60) % 60;
    long long hours = (totalMilliseconds / 1000 / 3600);
    
    if(milliseconds>=5){
        seconds+=1;
        if(seconds == 60){
            seconds = 0;
            minutes+=1;
            if(minutes == 60){
                minutes = 0;
                hours+=1;
            }
        }
    }
    
    if(hours == 0){
        return [NSString stringWithFormat:@"%02lli:%02lli", minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%02lli:%02lli:%02lli", hours, minutes, seconds];
    }
}

+ (NSString *)xy_stringFromSeconds:(UInt32)totalSeconds
{
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    NSInteger hours = (totalSeconds / 3600);
    
    if(hours == 0){
        return [NSString stringWithFormat:@"%li:%02li",(long) minutes, (long)seconds];
    }else{
        return [NSString stringWithFormat:@"%li:%02li:%02li", (long)hours, (long)minutes, (long)seconds];
    }
}

+ (NSDictionary *)xy_dictionaryWithJsonString:(NSString *)jsonString {
    
    if (!jsonString) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
}

@end
