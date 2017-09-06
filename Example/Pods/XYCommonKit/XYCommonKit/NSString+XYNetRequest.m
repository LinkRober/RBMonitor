//
//  NSString+XYNetRequest.m
//  Pods
//
//  Created by hongru qi on 2017/4/28.
//
//

#import "NSString+XYNetRequest.h"
#import "NSDictionary+XYJson.h"
#import "NSString+AppInfo.h"
#import "GTMBase64.h"
#import "XYSecurityUtility.h"
#import "OpenUDID.h"

@implementation NSString (XYNetRequest)

+ (NSString *)xy_methodSign:(NSDictionary *)params
{
    NSDictionary *body = params[@"body"];
    NSString *bodyJson = [body xy_JSONString];
    NSString *salt = [self xy_encodeBase64StringToString:[NSString xy_getAppKey]];
    
    NSString *needSignString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                                params[@"method"],
                                params[@"uri"],
                                bodyJson,params[@"time"],
                                [NSString xy_getAppKey],
                                salt];
    
    NSString* sign = [XYSecurityUtility md5HexDigest:needSignString];
    
    return sign;
}

+ (NSString *)xy_encodeBase64StringToString:(NSString * )input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString *)xy_udid
{
    NSString *openUdid = [OpenUDID value];
    NSString *udid = [NSString stringWithFormat:@"[I]%@",openUdid];
    return udid;
}

@end
