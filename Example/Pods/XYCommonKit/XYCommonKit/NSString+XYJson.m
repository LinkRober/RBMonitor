//
//  NSString+Json.m
//  Pods
//
//  Created by hongru qi on 2017/3/9.
//
//

#import "NSString+XYJson.h"

@implementation NSString (XYJson)

- (id)xy_objectFromJSONString
{
    NSData *dataJSON = [self dataUsingEncoding: NSUTF8StringEncoding];
    if(dataJSON){
        return [NSJSONSerialization JSONObjectWithData:dataJSON options: 0 error:nil];
    }
    return nil;
}

@end
