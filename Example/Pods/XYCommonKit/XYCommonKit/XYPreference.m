//
//  XYPreference.m
//  Pods
//
//  Created by hongru qi on 2017/1/19.
//
//

#import "XYPreference.h"
#import "NSString+XYDateStringExt.h"
#import "XYSecurityUtility.h"
#import "OpenUDID.h"

@implementation XYPreference

+ (void)xy_saveDate:(NSDate *)date key:(NSString *)key
{
    if(date && [date isKindOfClass:[NSDate class]]){
        NSString* strDate = [NSString xy_getDateStringWithFormat:@"yyyyMMddHHmmss" date:date];
        [self xy_savePreference:strDate key:key];
    }
}

+ (void)xy_savePreference:(id)data key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:key];
}

+ (NSString *)xy_loadPreference:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (id)xy_loadPreference:(NSString *)key defaultValue:(id)defaultValue {
    NSString *realKey = key;
    NSUserDefaults *saveDefaults = [NSUserDefaults standardUserDefaults];
    id value = [saveDefaults valueForKey:realKey];
    if(!value){
        value = defaultValue;
    }
    return value;
}

+ (void)xy_saveEncryptPreference:(id)data key:(NSString *)key
{
    NSString *encryptKey = [XYSecurityUtility encrypt:key key:[OpenUDID value]];
    NSString *encryptValue = [XYSecurityUtility encrypt:data key:[OpenUDID value]];
    [self xy_savePreference:encryptValue key:encryptKey];
}

+ (id)xy_loadEncryptPreference:(NSString *)key
{
    NSString *encryptKey = [XYSecurityUtility encrypt:key key:[OpenUDID value]];
    NSString *encryptValue = [self xy_loadPreference:encryptKey];
    NSString *decryptValue = [XYSecurityUtility decrypt:encryptValue key:[OpenUDID value]];
    return decryptValue;
}

+ (void)xy_saveCurrentTimeToPreference:(NSString *)key
{
    NSString* currentTime = [NSString xy_getDateStringWithFormat:@"yyyyMMddHHmmss" date:[NSDate date]];
    [self xy_savePreference:currentTime key:key];
}

+ (NSString *)xy_loadCurrentTimePreference:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

@end
