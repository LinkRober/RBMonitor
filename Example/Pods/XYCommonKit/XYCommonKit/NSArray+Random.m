//
//  NSArray+Random.m
//  Pods
//
//  Created by hongru qi on 2017/6/14.
//
//

#import "NSArray+Random.h"

@implementation NSArray (Random)

+ (NSArray *)xy_randomizedArray:(NSArray *)array
{
    NSMutableArray *results = [NSMutableArray arrayWithArray:array];
    
    NSInteger i = [results count];
    while(--i > 0) {
        int j = rand() % (i+1);
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    
    return [NSArray arrayWithArray:results];
}

@end
