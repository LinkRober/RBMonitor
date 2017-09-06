//
//  NSString+Sql.h
//  Pods
//
//  Created by hongru qi on 2017/6/13.
//
//

#import <Foundation/Foundation.h>


@interface NSString (Sql)

+ (NSString *)xy_createUpdateSQL:(NSString *)tableName
       withParameterDictionary:(NSDictionary *)argsDict
                           where:(NSString *)where;

+ (NSString *)xy_createInsertSQL:(NSString *)tableName withParameterDictionary:(NSDictionary *)argsDict;

@end
