//
//  NSString+XYHandle.h
//  Pods
//
//  Created by 夏敏 on 10/03/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XYHandle)

+ (NSUInteger)xy_unicodeLengthOfString:(NSString *)text;

+ (NSString *)xy_replaceBadChar:(NSString *)originalString;
/**
 Returns YES if the string is nil or equal to @""
 */
+ (BOOL)xy_isEmptyString:(NSString *)string;

+ (NSString *)xy_md5ForData:(NSData *)data;

+ (NSString *)xy_generateRandomString:(int)length;

+ (NSString*)xy_htmlDecode:(NSString*)strText;

+ (NSString*)xy_htmlEncode:(NSString*)strText;

+ (NSString*)xy_convertHelpStringToHtml:(NSString*)strHelp;

+ (NSMutableArray*)xy_separateString:(NSString*)strSrc start:(NSString*)startExpression end:(NSString*)endExpression;

+ (BOOL)xy_isSepecialString:(NSString*)srcString start:(NSString*)startExpression end:(NSString*)endExpression;

+ (NSString*)xy_getHexStringFromLongLong:(unsigned long long) longValue;

+ (unsigned long long)xy_getLongLongFromString:(NSString*) strLongLong;

+ (NSString *)xy_getCurrentLanguage;

+ (BOOL)xy_isNewVersion:(NSString *)newVersion localVersion:(NSString *)localVersion;

+ (NSString*)xy_convertDescStringToHtmlByPattern:(NSString*)strDesc isInChina:(BOOL)isInChina;

+ (NSString*)xy_convertDescStringToHtmlByPattern:(NSString*)strDesc
                                         pattern:(NSString*)pattern
                                  normalfontSize:(int)normalSize
                               highlightfontSize:(int)highlightSize
                                     normalColor:(NSString*)normalColor
                                  highlightColor:(NSString*)highligthColor;

+ (NSArray *)xy_getStringArrayFrom:(NSString *)originalString start:(NSString *)startString end:(NSString *)endString;

@end
