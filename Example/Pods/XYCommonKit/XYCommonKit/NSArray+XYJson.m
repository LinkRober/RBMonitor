//
//  NSArray+Json.m
//  Pods
//
//  Created by hongru qi on 2017/3/9.
//
//

#import "NSArray+XYJson.h"

@implementation NSArray (XYJson)

- (NSString *)xy_JSONString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];
    
    if (error == nil && jsonData != nil && [jsonData length] > 0){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    }else{
        return nil;
    }
}

@end
