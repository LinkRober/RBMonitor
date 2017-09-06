//
//  NSURL+Handle.m
//  Pods
//
//  Created by 夏敏 on 06/06/2017.
//
//

#import "NSURL+Handle.h"

@implementation NSURL (Handle)

+ (nullable instancetype)xy_encodedURLWithString:(NSString *__nullable)URLString
{
    if (((NSNull *) URLString == [NSNull null]) || (!URLString)) {
        return nil;
    }
    NSURL *urlAfterEncode = nil;
    if (([[[UIDevice currentDevice] systemVersion] compare:@"9.0" options:NSNumericSearch] != NSOrderedAscending)) {
        urlAfterEncode = [NSURL URLWithDataRepresentation:[URLString dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil];
    }else{
        URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        urlAfterEncode = [NSURL URLWithString:URLString];
    }
    return urlAfterEncode;
}

@end
