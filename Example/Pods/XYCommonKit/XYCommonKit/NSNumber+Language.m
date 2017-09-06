//
//  NSNumber+Language.m
//  Pods
//
//  Created by hongru qi on 2017/2/25.
//
//

#import "NSNumber+Language.h"
#import "XYDeviceUtility.h"

#define APP_LOCALIZATION_ID_DECIMAL             0x0409 //english.
#define LANG_ID_ZH_CHS                          0x0004 //Chinese Simplified Language

@implementation NSNumber (Language)

+ (NSInteger)xy_getLanguageID
{
    NSString *language = [XYDeviceUtility language];
    return [self xy_getLanguageID:language];
}

+ (NSInteger)xy_getLanguageID:(NSString *)language
{
    if([language hasPrefix:@"zh_CN"] || [language hasPrefix:@"zh-Hans"]){
        return LANG_ID_ZH_CHS;
    }else{
        return APP_LOCALIZATION_ID_DECIMAL;
    }
}

@end
