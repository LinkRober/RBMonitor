//
//  NSString+XYValidate.m
//  Pods
//
//  Created by hongru qi on 2017/2/27.
//
//

#import "NSString+XYValidate.h"
#import "NSString+XYDateStringExt.h"

@implementation NSString (XYValidate)

+ (BOOL)xy_isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)xy_isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1+[3578]+\\d{9}";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)xy_isValidateQQ:(NSString *)qq
{
    NSString *qqRegex = @"[1-9][0-9]{4,}";
    NSPredicate *qqTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",qqRegex];
    return [qqTest evaluateWithObject:qq];
}

+ (BOOL)xy_isValidatePassword:(NSString *)password
{
    NSString *pattern = @"^[A-Za-z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

+ (BOOL)xy_isValidateVerifyCode:(NSString *)verifyCode
{
    if (![NSString xy_isEmptyString:verifyCode]) {
        NSInteger length = verifyCode.length;
        if (length >= 4 && length <= 10) {
            return YES;
        }
    }
    return NO;
}


@end
