//
//  XYDateFormatUtility.h
//  Pods
//
//  Created by hongru qi on 2017/6/2.
//
//

#import <Foundation/Foundation.h>

@interface XYDateFormatUtility : NSObject

+ (instancetype)instance;

+ (NSDateFormatter *)formatterFormString:(NSString *)formatString;

@end
