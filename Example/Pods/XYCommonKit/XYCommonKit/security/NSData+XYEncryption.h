//
//  NSData+XYEncryption.h
//  Pods
//
//  Created by hongru qi on 2017/2/17.
//
//

#import <Foundation/Foundation.h>

@interface NSData (XYEncryption)

- (NSData *)XY_AES256EncryptWithKey:(NSString *)key;
- (NSData *)XY_AES256DecryptWithKey:(NSString *)key;

@end
