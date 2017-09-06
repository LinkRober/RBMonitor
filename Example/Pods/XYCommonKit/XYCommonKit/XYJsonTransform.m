//
//  WTJsonTransform.m
//  Pods
//
//  Created by hongru qi on 2017/4/7.
//
//

#import "XYJsonTransform.h"
#import <objc/runtime.h>

@implementation XYJsonTransform

+ (NSDictionary *)xy_TransformModelDictionary:(NSObject *)model
{

    Class object = model.class;
    unsigned propertyCount;
    objc_property_t *properties = class_copyPropertyList(object, &propertyCount);
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:5];
    
    for(int i = 0; i < propertyCount; i++){
        objc_property_t prop = properties[i];
        
        NSString * propName = [NSString stringWithFormat: @"%s", property_getName(prop)];
        id value = [model valueForKey:propName];
        [dict setValue:value forKey:propName];
    }
    
    free(properties);
    
    return dict;
}

+ (id)xy_TransformJSONModel:(id)json className:(NSString *)className
{
    NSDictionary *transfromDic = [XYJsonTransform dictionaryWithJSON:json];
    return [XYJsonTransform xy_TransformDictionaryModel:transfromDic className:className];
}

+ (id)xy_TransformDictionaryModel:(NSDictionary *) dict className: (NSString *) className
{
    // 分析类属性和方法签名
    // 获取对象的全部属性，及set方法特性参数
    Class class = NSClassFromString(className);
    NSDictionary *propDict = [self parsedPropertiesOfClass:class];
    
    id obj = [[class alloc] init];
    NSRegularExpression * modelReg = [NSRegularExpression regularExpressionWithPattern:@"(.+)" options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray * array = [dict allKeys];
    NSEnumerator *enumlator = [array objectEnumerator];
    NSString *string;
    
    while (string = [enumlator nextObject])
    {
        // 过滤无效key
        if (![string isKindOfClass:[NSString class]]) {
            continue;
        }
        
        
        NSString *propertyName = [string stringByReplacingOccurrencesOfString:@"_" withString:@"."];
        propertyName = [propertyName stringByReplacingOccurrencesOfString:@"." withString:@""];
        
        NSString *setMethod = [NSString stringWithFormat:@"set%@%@:", [[propertyName substringToIndex:1] capitalizedString], [propertyName substringFromIndex:1]];
        
        if ([obj respondsToSelector:NSSelectorFromString(setMethod)])
        {
            id value = [dict objectForKey:string];
            
            if ([value isKindOfClass:[NSArray class]]) {
                if ([(NSArray *)value count] > 0 && [value[0] isKindOfClass: [NSDictionary class]]) {
                    // 拼装模型
                    NSString * innerModelName;
                    Class innerClass;
                    
                    if([class respondsToSelector:@selector(xy_PropertyGenericClass)]){
                        innerModelName = [class xy_PropertyGenericClass][propertyName];
                        innerClass = NSClassFromString(innerModelName);
                    }else{
                        innerModelName = [NSString stringWithFormat:@"%@", [[propertyName capitalizedString] substringToIndex: [propertyName length]]];
                        innerClass = NSClassFromString(innerModelName);
                    }
                    
                    NSMutableArray * _value = [[NSMutableArray alloc] initWithCapacity: [(NSArray *)value count]];
                    
                    if (innerClass) {
                        for (NSDictionary* tmpDict in value) {
                            [_value addObject: [self xy_TransformDictionaryModel:tmpDict className:innerModelName]];
                        }
                        value = _value;
                    }
                }
            } else {
                NSString * propertyType = [propDict valueForKey:propertyName];
                
                if (propertyType) {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        NSUInteger count =[modelReg numberOfMatchesInString:propertyType options:NSMatchingReportProgress range:NSMakeRange(0, [propertyType length])];
                        if (count > 0) {
                            if (![value isEqual:[NSNull null]]) {
                                value = [self xy_TransformDictionaryModel:value className:propertyType];
                            }
                        }
                    } else if ([propertyType isEqualToString:@"NSNumber"]) {
                        if (![value isEqual:[NSNull null]]) {
                            if ([value isKindOfClass:[NSString class]]) {
                                if ([value isEqualToString:@"true"]) {
                                    value = @"1";
                                } else if ([value isEqualToString:@"false"]) {
                                    value = @"0";
                                }
                            }
                            value = [NSNumber numberWithDouble: [value doubleValue]];
                        }else{
                            value = [NSNumber numberWithInt:0];
                        }
                    } else if ([propertyType isEqualToString:@"NSString"]) {
                        if (![value isEqual:[NSNull null]]) {
                            if ([value isKindOfClass:[NSNumber class]]) {
                                value = [value stringValue];
                            }
                        } else {
                            value = @"";
                        }
                        
                    } else if ([propertyType isEqualToString:@"NSArray"]) {
                        value = nil;
                    }
                }
            }
            
            SEL sel = NSSelectorFromString(setMethod);
            NSMethodSignature *sig = [obj methodSignatureForSelector:sel];
            NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
            [inv setArgument:&value atIndex:2];
            [inv setSelector:sel];
            [inv invokeWithTarget:obj];
        }
    }
    
    return obj;
}

+ (NSDictionary *)parsedPropertiesOfClass:(Class)class
{
    // 分析类属性和方法签名
    NSMutableDictionary * propertyDict = [[NSMutableDictionary alloc] init];
    
    static NSString * const typePattern = @"T@\"(.+)\"";
    NSRegularExpression * typeReg = [NSRegularExpression regularExpressionWithPattern:typePattern
                                                                              options:NSRegularExpressionCaseInsensitive
                                                                                error:nil];
    unsigned propertyCount;
    
    //获取对象的全部属性，及set方法特性参数
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for(NSInteger i = 0; i < propertyCount; i++){
        objc_property_t property = properties[i];
        NSString * propertyName = [NSString stringWithFormat: @"%s", property_getName(property)];
        NSString * selector = [NSString stringWithFormat:@"%s", property_getAttributes(property)];
        NSArray * matches = [typeReg matchesInString:selector options:NSMatchingReportCompletion range:NSMakeRange(0, [selector length])];
        
        if (matches.count == 0) {
            // TB,N,V_bNameChanged
            continue;
        }
        
        NSString * propertyType = [selector substringWithRange:[matches[0] rangeAtIndex:1]];
        [propertyDict setObject:propertyType forKey:propertyName];
    }
    
    free(properties);
    
    // 递归取父类的属性
    Class superclass = class_getSuperclass(class);
    if (class_getSuperclass(superclass) != nil) {   // if superclass is not root class
        [propertyDict addEntriesFromDictionary:[self parsedPropertiesOfClass:superclass]];
    }
    
    return propertyDict;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////
+ (NSMutableDictionary *)xy_TransfromObjc:(NSObject *)object toDict:(NSMutableDictionary *) dict
{
    Class class = object.class;
    
    unsigned propertyCount;
    objc_property_t *properties = class_copyPropertyList(class,&propertyCount);
    
    for(int i=0;i<propertyCount;i++){
        objc_property_t property = properties[i];
        
        NSString * propertyName = [NSString stringWithFormat: @"%s", property_getName(property)];
        id value = [object valueForKey:propertyName];
        [dict setValue:value forKey:propertyName];
    }
    
    free(properties);
    
    return dict;
}

+ (NSDictionary *)dictionaryWithJSON:(id)json
{
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    
    return dic;
}

@end

@implementation NSString (XYTransform)

- (NSDictionary *)xy_JsonTransform
{
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&error];
    
    if(error){
        return nil;
    }else{
        return jsonDict;
    }
}
@end


@implementation NSObject (XYTransform)

- (NSDictionary *)xy_TransformDict
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    Class class = self.class;
    
    unsigned propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for(int i = 0; i < propertyCount; i++){
        objc_property_t property = properties[i];
        NSString * propertyName = [NSString stringWithFormat: @"%s", property_getName(property)];
        id value = [self valueForKey:propertyName];
        
        if([value isKindOfClass:[NSSet class]] || [value isKindOfClass:[NSArray class]]) {
            [dict setValue:[value class] forKey:propertyName];
        }else if([value isKindOfClass:[NSDictionary class]]) {
            [dict setValue:[(NSDictionary *)value xy_TransformDict] forKey:propertyName];
        }else{
            [dict setValue:value forKey:propertyName];
        }
    }
    
    free(properties);
    
    return dict;
}

@end
