//
//  XYSecurityUtility.h
//  XiaoYing
//
//  Created by Mac on 13-7-13.
//  Copyright (c) 2013年 XiaoYing Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AES_ALGORITHM @"AES"
#define DES_ALGORITHM @"DES"
#define RSA_ALGORITHM @"RSA"

@interface XYSecurityUtility : NSObject
+ (NSString *)makeAppSecretKey:(NSString *)strAppKey date:(NSString *)strDate extKey:(NSString *)extKey;
+ (NSString *)makeDigestKey:(NSString *)strAppKey secretKey:(NSString *)strSecretKey encryptKey: (NSString *)strEncryptKey;
+ (NSString *)md5HexDigest:(NSString*)strInput;
+ (NSString *)encrypt:(NSString*)plainText key:(NSString *)key;
+ (NSString *)decrypt:(NSString*)encryptText key:(NSString *)key;
+ (NSString *)encryptUseAES:(NSString*)plainText key:(NSString *)key;
+ (NSString *)decryptUseAES:(NSString*)encryptText key:(NSString *)key;


#pragma mark - base64
+ (NSString *)encodeBase64StringToString:(NSString * )input;
+ (NSString *)decodeBase64StringToString:(NSString * )input;
+ (NSString *)encodeBase64DataToString:(NSData *)data;
+ (NSString *)decodeBase64DataToString:(NSData *)data;
+ (NSData *)encodeBase64StringToData:(NSString * )input;
+ (NSData *)decodeBase64StringToData:(NSString * )input;
+ (NSData *)encodeBase64DataToData:(NSData * )data;
+ (NSData *)decodeBase64DataToData:(NSData * )data;

#pragma mark - AES加密
//将string转成带密码的data
+ (NSData*)encryptAESData:(NSString *)string key:(NSString *)key;
//将带密码的data转成string
+ (NSString*)decryptAESData:(NSData *)data key:(NSString *)key;


#pragma mark - DES加密
+(NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;

// DES decrypt
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;


#pragma mark - MD5加密
/**
 *	@brief	对string进行md5加密
 *
 *	@param 	string 	未加密的字符串
 *
 *	@return	md5加密后的字符串
 */
+ (NSString*)encryptMD5String:(NSString*)string;
@end
