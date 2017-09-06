//
//  NSString+XYValidate.h
//  Pods
//
//  Created by hongru qi on 2017/2/27.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XYValidate)

+ (BOOL)xy_isValidateEmail:(NSString *)email;

+ (BOOL)xy_isValidateMobile:(NSString *)mobile;

+ (BOOL)xy_isValidateQQ:(NSString *)qq;

+ (BOOL)xy_isValidatePassword:(NSString *)password;

+ (BOOL)xy_isValidateVerifyCode:(NSString *)verifyCode;

@end
