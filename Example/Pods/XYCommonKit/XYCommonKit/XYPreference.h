//
//  XYPreference.h
//  Pods
//
//  Created by hongru qi on 2017/1/19.
//
//

#import <Foundation/Foundation.h>

@interface XYPreference : NSObject

+ (void)xy_saveDate:(NSDate *)date key:(NSString *)key;

+ (void)xy_savePreference:(id)data key:(NSString *)key;

+ (id)xy_loadPreference:(NSString *)key;

+ (id)xy_loadPreference:(NSString *)key defaultValue:(id)defaultValue;

+ (void)xy_saveEncryptPreference:(id)data key:(NSString *)key;

+ (id)xy_loadEncryptPreference:(NSString *)key;

+ (void)xy_saveCurrentTimeToPreference:(NSString *)key;

+ (NSString *)xy_loadCurrentTimePreference:(NSString *)key;

@end
