//
//  XYDateFormatUtility.m
//  Pods
//
//  Created by hongru qi on 2017/6/2.
//
//

#import "XYDateFormatUtility.h"

@interface XYDateFormatUtility()

@property (nonatomic, strong) NSDictionary *dateFormatDict;

@end

@implementation XYDateFormatUtility

+ (instancetype)instance
{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.dateFormatDict = @{
                                @"yyyy-MM-dd HH:mm:ss":[self createFormatWithString:@"yyyy-MM-dd HH:mm:ss"],
                                @"yyyy-MM-dd HH:mm":[self createFormatWithString:@"yyyy-MM-dd HH:mm"],
                                @"yyyy-MM-dd":[self createFormatWithString:@"yyyy-MM-dd"],
                                @"yyyyMMddHHmmss":[self createFormatWithString:@"yyyyMMddHHmmss"],
                                @"yyyy/MM/dd":[self createFormatWithString:@"yyyy/MM/dd"],
                                @"'at' h:mm a":[self createFormatWithString:@"'at' h:mm a"],
                                @"h:mm a":[self createFormatWithString:@"h:mm a"],
                                @"EEEE h:mm a":[self createFormatWithString:@"EEEE h:mm a"],
                                @"EEEE":[self createFormatWithString:@"EEEE"],
                                @"MMM d h:mm a":[self createFormatWithString:@"MMM d h:mm a"],
                                @"MMM d":[self createFormatWithString:@"MMM d"],
                                @"MMM d, yyyy h:mm a":[self createFormatWithString:@"MMM d, yyyy h:mm a"],
                                @"MMM d, yyyy":[self createFormatWithString:@"MMM d, yyyy"],
                                @"yyyy/MM/dd":[self createFormatWithString:@"yyyy/MM/dd"],
                                @"yyyy年MM月dd日":[self createFormatWithString:@"yyyy年MM月dd日"]
                                };
    }
    return self;
}

- (NSDateFormatter *)createFormatWithString:(NSString *)formatString
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    return dateFormat;
}

+ (NSDateFormatter *)formatterFormString:(NSString *)formatString
{
    NSDateFormatter *resultDateFormat = [[XYDateFormatUtility instance] dateFormatDict][formatString];
    if (resultDateFormat) {
        return resultDateFormat;
    }
    return [[self instance] createFormatWithString:formatString];
}
@end
