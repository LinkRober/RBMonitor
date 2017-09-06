//
//  NSURL+Handle.h
//  Pods
//
//  Created by 夏敏 on 06/06/2017.
//
//

#import <Foundation/Foundation.h>

@interface NSURL (Handle)


/**
 This method will return a percent-encoded URL.
 */
+ (nullable instancetype)xy_encodedURLWithString:(NSString *__nullable)URLString;

@end
