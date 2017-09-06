//
//  WTJsonTransform.h
//  Pods
//
//  Created by hongru qi on 2017/4/7.
//
//

#import <Foundation/Foundation.h>

@interface XYJsonTransform : NSObject

/**
 * object c 本地dictionary 转化为object
 * 仅仅设置dict中有的属性 属性名和key必须一致
 */
+ (NSDictionary *)xy_TransformModelDictionary:(NSObject *)model;

+ (id)xy_TransformDictionaryModel:(NSDictionary *)dict className:(NSString *)className;

+ (id)xy_TransformJSONModel:(id)json className:(NSString *)className;

@end

@interface NSString (XYTransform)

- (NSDictionary *)xy_JsonTransform;

@end

@interface NSObject (XYTransform)

- (NSDictionary *)xy_TransformDict;

@end

@protocol XYModel <NSObject>

+ (NSDictionary *)xy_PropertyGenericClass;

@end
