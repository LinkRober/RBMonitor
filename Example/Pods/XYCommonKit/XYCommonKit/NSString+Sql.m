//
//  NSString+Sql.m
//  Pods
//
//  Created by hongru qi on 2017/6/13.
//
//

#import "NSString+Sql.h"

@implementation NSString (Sql)

+ (NSString *)xy_createUpdateSQL:(NSString *)tableName
       withParameterDictionary:(NSDictionary *)argsDict
                         where:(NSString *)where
{
    NSEnumerator *enumerator = [argsDict keyEnumerator];
    id key;
    NSString *temp = @"";
    
    while ((key = [enumerator nextObject])) {
        id value = [argsDict valueForKey:key];
        if([value isKindOfClass:[NSString class]]){
            value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
            temp = [temp stringByAppendingFormat:@"%@='%@',",key,value];
        }else if([value isKindOfClass:[NSNumber class]]){
            temp = [temp stringByAppendingFormat:@"%@=%@,",key,[value stringValue]];
        }else{
            NSLog(@"this is wrong format value");
        }
        
    }
    NSUInteger tempLength = [temp length];
    if(tempLength>0){
        temp = [temp substringToIndex:tempLength-1];
    }
    NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@;",tableName,temp,where];
    return sql;
}

+ (NSString *)xy_createInsertSQL:(NSString *)tableName withParameterDictionary:(NSDictionary *)argsDict
{
    NSEnumerator *enumerator = [argsDict keyEnumerator];
    id key;
    NSString *tempValues = @"";
    NSString *tempKeys = @"";
    
    while ((key = [enumerator nextObject])) {
        id value = [argsDict valueForKey:key];
        if([value isKindOfClass:[NSString class]]){
            value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
            tempValues = [tempValues stringByAppendingFormat:@"'%@',",value];
        }else if([value isKindOfClass:[NSNumber class]]){
            tempValues = [tempValues stringByAppendingFormat:@"%@,",[value stringValue]];
        }else{
            NSLog(@"this is wrong format value");
            continue;
        }
        tempKeys = [tempKeys stringByAppendingFormat:@"%@,",key];
    }
    NSUInteger valuesLength = [tempValues length];
    if(valuesLength>0){
        tempValues = [tempValues substringToIndex:valuesLength-1];
    }
    NSUInteger keyLength = [tempKeys length];
    if(keyLength>0){
        tempKeys = [tempKeys substringToIndex:keyLength-1];
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@);",tableName,tempKeys,tempValues];
    return sql;
}

@end
