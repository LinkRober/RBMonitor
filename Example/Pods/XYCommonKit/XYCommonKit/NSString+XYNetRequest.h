//
//  NSString+XYNetRequest.h
//  Pods
//
//  Created by hongru qi on 2017/4/28.
//
//

#import <Foundation/Foundation.h>

@interface NSString (XYNetRequest)

+ (NSString *)xy_methodSign:(NSDictionary *)params;

+ (NSString *)xy_encodeBase64StringToString:(NSString *)input;

+ (NSString *)xy_udid;

@end
