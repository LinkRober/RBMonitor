//
//  NSString+XYHandle.m
//  Pods
//
//  Created by 夏敏 on 10/03/2017.
//
//

#import "NSString+XYHandle.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+XYDateStringExt.h"

@implementation NSString (XYHandle)


+ (NSUInteger)xy_unicodeLengthOfString:(NSString *) text
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    return asciiLength;
}

+ (NSString *)xy_replaceBadChar:(NSString *)originalString
{
    
    NSString *trimmedString = [originalString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@":" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"/" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"*" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"?" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@">" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"|" withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    return trimmedString;
}

+ (BOOL)xy_isEmptyString:(NSString *)string;
{
    if (((NSNull *) string == [NSNull null]) || (string == nil) || ![string isKindOfClass:(NSString.class)]) {
        return YES;
    }
    
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)xy_md5ForData:(NSData *)data
{
    if( !data || ![data length] )
        return nil;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5([data bytes], (CC_LONG)[data length], result);
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (NSString *)xy_generateRandomString:(int)length
{
    char data[length];
    for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *randomString = [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    return randomString;
}

+(NSString*)xy_htmlDecode:(NSString*)strText
{
    if([self xy_isEmptyString:strText]){
        return strText;
    }
    
    strText = [strText stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    strText = [strText stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    strText = [strText stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    strText = [strText stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    strText = [strText stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    strText = [strText stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    return strText;
}

+ (NSString*)xy_htmlEncode:(NSString*)strText
{
    if([self xy_isEmptyString:strText]){
        return strText;
    }
    
    strText = [strText stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    strText = [strText stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    strText = [strText stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    strText = [strText stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    strText = [strText stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    return strText;
}

+ (NSString*)xy_convertHelpStringToHtml:(NSString*)strHelp
{
    if([self xy_isEmptyString:strHelp]){
        return strHelp;
    }

    NSMutableArray* separateStringList = [self xy_separateString:strHelp start:@"[" end:@"]"];
    NSString*  html = @"";
    for (NSString* separate in separateStringList) {
        NSString* newSeparateHtml;
        if ([self xy_isSepecialString:separate start:@"[" end:@"]"]) {
            NSString* newSeparate = separate;
            if ([newSeparate isEqualToString:@"##"]  == NO) {
                newSeparate = [separate substringWithRange:NSMakeRange(1, separate.length-2)];
            };
            newSeparateHtml = [NSString stringWithFormat:@"<span color='#ffffff' size='16'>%@</span>",newSeparate];
        }else{
            newSeparateHtml = [NSString stringWithFormat:@"<span color='#ffffff' size='14'>%@</span>",separate];
        }
        html = [NSString stringWithFormat:@"%@%@",html,newSeparateHtml];
    }
    
    return html;
}

+ (NSMutableArray*)xy_separateString:(NSString*)strSrc start:(NSString*)startExpression end:(NSString*)endExpression
{
    //NSLog(@"src:%@",strSrc);
    NSMutableArray* strList = [[NSMutableArray alloc] init];
    if (strSrc == nil) {
        return strList;
    }
    
    NSString* subString = strSrc;
    while (subString != nil) {
        NSRange startRange = [subString rangeOfString:startExpression];
        NSUInteger startIndex = startRange.location;
        
        //找到start index，并且start index不在最后。
        if (startIndex != NSNotFound && startIndex < (subString.length -1)) {
            //这里算endRange,需要startIndex开始
            NSRange searchEndRange = NSMakeRange(startIndex+1, subString.length - startIndex -1);
            NSRange endRange = [subString rangeOfString:endExpression options:NSLiteralSearch range:searchEndRange];
            NSUInteger endIndex = endRange.location;
            if (endIndex != NSNotFound) {
                if(startIndex > 0){
                    NSString* normal = [subString substringWithRange:NSMakeRange(0, startIndex)];
                    [strList addObject:normal];
                }
                
                NSString* sepecial = [subString substringWithRange:NSMakeRange(startIndex, endIndex - startIndex + 1)];
                [strList addObject:sepecial];
                
                if(endIndex == (subString.length -1)){
                    break;
                }else{
                    subString = [subString substringWithRange:NSMakeRange(endIndex + 1, subString.length-endIndex-1)];
                }
            }else{
                [strList addObject:subString];
                break;
            }
        }else{
            [strList addObject:subString];
            break;
        }
    }
    
    return  strList;
}

+ (BOOL)xy_isSepecialString:(NSString*)srcString start:(NSString*)startExpression end:(NSString*)endExpression
{
    if ([self xy_isEmptyString:srcString]) {
        return NO;
    }
    if ([srcString hasPrefix:startExpression] && [srcString hasSuffix:endExpression]) {
        return YES;
    }
    return NO;
}

+ (NSString*)xy_getHexStringFromLongLong:(unsigned long long) longValue
{
    NSString* strTtid = [NSString stringWithFormat:@"0x%016llX",longValue];
    return strTtid;
}

+ (unsigned long long)xy_getLongLongFromString:(NSString*) strLongLong
{
    NSScanner* scanner = [NSScanner scannerWithString:strLongLong];
    unsigned long long longlongTtid = 0;
    [scanner scanHexLongLong: &longlongTtid];
    return longlongTtid;
}

+ (NSString *)xy_getCurrentLanguage
{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    return preferredLang;
}

+ (BOOL)xy_isNewVersion:(NSString *)newVersion localVersion:(NSString *)localVersion
{
    if(!localVersion){
        return YES;
    }
    NSArray*oldV = [localVersion componentsSeparatedByString:@"."];
    NSArray*newV = [newVersion componentsSeparatedByString:@"."];
    
    NSInteger count = MAX([oldV count], [newV count]);
    
    for (NSInteger i = 0; i < count; i++) {
        if (i == oldV.count) {//local version has lesser segment(eg:2.2 vs 2.2.1)
            return YES;
        }
        if (i == newV.count) {//new version has lesser segment(generally impossible)
            return NO;
        }
        NSInteger oldI = [(NSString *)[oldV objectAtIndex:i] integerValue];
        NSInteger newI = [(NSString *)[newV objectAtIndex:i] integerValue];
        if (oldI < newI) {
            return YES;
        }else if(oldI > newI){
            return NO;
        }
    }
    return NO;
}

+ (NSString*)xy_convertDescStringToHtmlByPattern:(NSString*)strDesc isInChina:(BOOL)isInChina
{
    if([NSString xy_isEmptyString:strDesc] ){
        return strDesc;
    }
    
    strDesc = [strDesc stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    strDesc = [strDesc stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    strDesc = [strDesc stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    strDesc = [strDesc stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    strDesc = [strDesc stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    
    NSString* pattern = @"(#[^#]+?#)";
    if (isInChina == NO) {
        pattern = @"(#[^ #]+?)(?= |#|$)";
    }
    
    return [self xy_convertDescStringToHtmlByPattern:strDesc
                                             pattern:pattern
                                      normalfontSize:16
                                   highlightfontSize:16
                                         normalColor:@"#151515"
                                      highlightColor:@"#155599"];
}

+ (NSString*)xy_convertDescStringToHtmlByPattern:(NSString*)strDesc
                                     pattern:(NSString*)pattern
                              normalfontSize:(int)normalSize
                           highlightfontSize:(int)highlightSize
                                 normalColor:(NSString*)normalColor
                              highlightColor:(NSString*)highligthColor
{
    if([NSString xy_isEmptyString:strDesc] ){
        return strDesc;
    }
    
    __block NSString *tagResult = @"";
    NSError *error = NULL;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeTotal = [strDesc rangeOfString:strDesc];
    __block NSUInteger length = rangeTotal.length;
    if (length <= 0) {
        return tagResult;
    }
    __block NSInteger currentLocation = 0;
    
    [expression enumerateMatchesInString:strDesc
                                 options:0
                                   range:rangeTotal
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  
                                  NSRange subRange = [result range];
                                  NSUInteger subLocation = subRange.location;
                                  NSUInteger subLength = subRange.length;
                                  NSString* subString = [strDesc substringWithRange:subRange];
                                  if(currentLocation < subLocation){
                                      NSRange beforeSubRange = NSMakeRange(currentLocation, (subLocation - currentLocation));
                                      NSString* beforeSubString = [strDesc substringWithRange:beforeSubRange];
                                      beforeSubString = [NSString stringWithFormat:@"<span color='%@' size='%d'>%@</span>",
                                                         normalColor,normalSize,beforeSubString];
                                      
                                      if ([tagResult isEqualToString:@""]) {
                                          tagResult = beforeSubString;
                                      }else{
                                          tagResult = [NSString stringWithFormat:@"%@%@",tagResult,beforeSubString];
                                      }
                                  }
                                  
                                  if ([subString isEqualToString:@"##"] ||
                                      [subString isEqualToString:@"# #"] ||
                                      [subString isEqualToString:@"#"] ||
                                      [subString isEqualToString:@"# "] ) {
                                      subString = [NSString stringWithFormat:@"<span color='%@' size='%d'>%@</span>",
                                                   normalColor,normalSize,subString];
                                  }else{
                                      NSString* passParam;
                                      passParam = [subString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                      subString = [NSString stringWithFormat:@"<a href='http://%@' color='%@' size='%d'><b>%@</b></a>",
                                                   passParam,highligthColor,highlightSize,subString];
                                  }
                                  
                                  
                                  
                                  if ([tagResult isEqualToString:@""]) {
                                      tagResult = subString;
                                  }else{
                                      tagResult = [NSString stringWithFormat:@"%@%@",tagResult,subString];
                                  }
                                  
                                  currentLocation = subLocation + subLength;
                              }];
    if ( currentLocation < rangeTotal.length ) {
        NSRange beforeSubRange = NSMakeRange(currentLocation, (rangeTotal.length - currentLocation));
        NSString* beforeSubString = [strDesc substringWithRange:beforeSubRange];
        beforeSubString = [NSString stringWithFormat:@"<span color='%@' size='%d'>%@</span>",
                           normalColor,normalSize,beforeSubString];
        
        if ([tagResult isEqualToString:@""]) {
            tagResult = beforeSubString;
        }else{
            tagResult = [NSString stringWithFormat:@"%@%@",tagResult,beforeSubString];
        }
    }
    
    return tagResult;
}

+ (NSArray *)xy_getStringArrayFrom:(NSString *)originalString start:(NSString *)startString end:(NSString *)endString
{
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    if ([NSString xy_isEmptyString:originalString]) {
        return stringArray;
    }
    NSString *regex = [NSString stringWithFormat:@"\\%@(.*?)\\%@",startString,endString];
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex
                                                                             options:NSRegularExpressionCaseInsensitive
                                                                               error:&error];
    // 对str字符串进行匹配
    NSArray *matches = [regular matchesInString:originalString
                                        options:0
                                          range:NSMakeRange(0, originalString.length)];
    // 遍历匹配后的每一条记录
    for (NSTextCheckingResult *match in matches) {
        NSRange range = [match range];
        NSString *mStr = [originalString substringWithRange:range];
        mStr = [mStr stringByReplacingOccurrencesOfString:startString withString:@""];
        mStr = [mStr stringByReplacingOccurrencesOfString:endString withString:@""];
        if (![NSString xy_isEmptyString:mStr]) {
            [stringArray addObject:mStr];
        }
    }
    return stringArray;
}


@end
