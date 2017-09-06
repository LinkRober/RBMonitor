//
//  XYSecurityUtility.m
//  XiaoYing
//
//  Created by Mac on 13-7-13.
//  Copyright (c) 2013年 XiaoYing Team. All rights reserved.
//

#import "XYSecurityUtility.h"
#import <stdio.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "GTMBase64.h"
#import "NSString+MD5Encryption.h"
#import "NSData+XYEncryption.h"

#define DEFAULT_SECRET @"http:xiaoying.quvideo.tv"
#define DEFAULT_IV     @"20060427"

static int makeSalt(int value){
	int result;
	int num = 0;
	while(value > 0){
		num = value - value/10*10 + num;
		value = value/10;
	}
	
	if(num/10 > 0){
		result = makeSalt(num);
	}else{
		result = num;
	}
	//NSLog(@"makeSalt, input=%d, salt=%d", nOriValue, result);
	return result;
}

static void makeKey(char* pszOutput, const char* pszKey1, const char* pszKey2, const char* pszKey3, int nSalt) {
	char szSalt[10] = {0};
	if(pszOutput == NULL)
		return;
    
	pszOutput[0] = 0;
	if(pszKey1 != NULL)
		strcat(pszOutput, pszKey1);
    
	if(pszKey2 != NULL)
		strcat(pszOutput, pszKey2);
    
	if(pszKey3 != NULL)
		strcat(pszOutput, pszKey3);
	
	//itoa(nSalt, szSalt, 10);
	sprintf(szSalt, "%d", nSalt);
	strcat(pszOutput, szSalt);
}

@implementation XYSecurityUtility

+ (NSString*)makeAppSecretKey: (NSString*)strAppKey date:(NSString*)strDate extKey: (NSString*)extKey {
    int nSeed = atoi([strAppKey UTF8String]);
	int nSalt = makeSalt(nSeed);
	char szKey[256] = {0};
	makeKey(szKey, [strAppKey UTF8String], [strDate UTF8String], [extKey UTF8String], nSalt);
    return [NSString stringWithUTF8String:szKey];
}

+ (NSString*)makeDigestKey: (NSString*)strAppKey secretKey:(NSString*)strSecretKey encryptKey: (NSString*)strEncryptKey {
    const char* pszAppkey = [strAppKey UTF8String];
	const char* pszAppSecretKey = [strSecretKey UTF8String];
	char* pszAuid = NULL;
	if(strEncryptKey != nil)
		pszAuid = (char*)[strEncryptKey UTF8String];
	
	int nSeed = 0;
	if(pszAuid == NULL || 0 == strlen(pszAuid)){
		nSeed = atoi(pszAppkey);
	}else{
		int nAuidLen = (int)strlen(pszAuid);
		nSeed        = (int)(pszAuid[nAuidLen - 1]);
	}
	
	int nSalt = makeSalt(nSeed);
	char szKey[256] = {0};
	makeKey(szKey, pszAppkey, pszAppSecretKey, pszAuid, nSalt);
	return [NSString stringWithUTF8String:szKey];
}

+ (NSString *)md5HexDigest: (NSString*)strInput
{
    if(strInput == nil)
        return nil;
    
    const char *original_str = [strInput UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


#define DES_INIT_VEC  @"20060427"


#pragma mark - base64
+ (NSString*)encodeBase64StringToString:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64StringToString:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)encodeBase64DataToString:(NSData *)data {
	data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSString*)decodeBase64DataToString:(NSData *)data {
	data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	return base64String;
}

+ (NSData*)encodeBase64StringToData:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
	return data;
}

+ (NSData*)decodeBase64StringToData:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
	return data;
}

+ (NSData*)encodeBase64DataToData:(NSData * )data {
    data = [GTMBase64 encodeData:data];
	return data;
}

+ (NSData*)decodeBase64DataToData:(NSData * )data {
    data = [GTMBase64 decodeData:data];
	return data;
}

#pragma mark - AES加密
//将string转成带密码的data
+(NSData*)encryptAESData:(NSString*)string key:(NSString *)key{
    //将nsstring转化为nsdata
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data XY_AES256EncryptWithKey:key];
    return encryptedData;
}

//将带密码的data转成string
+(NSString*)decryptAESData:(NSData*)data key:(NSString *)key{
    //使用密码对data进行解密
    NSData *decryData = [data XY_AES256DecryptWithKey:key];
    //将解了密码的nsdata转化为nsstring
    NSString *string = [[NSString alloc] initWithData:decryData encoding:NSUTF8StringEncoding];
    return string;
}

#pragma mark - MD5加密
/**
 *	@brief	对string进行md5加密
 *
 *	@param 	string 	未加密的字符串
 *
 *	@return	md5加密后的字符串
 */
+ (NSString*)encryptMD5String:(NSString*)string {
    return [string XY_MD5Encrypt];
}


// 加密方法
+ (NSString*)encryptUseAES:(NSString*)plainText key:(NSString *)key {
    NSLog(@"Input str=%@",plainText);
    NSData *resultData = [XYSecurityUtility encryptAESData:plainText key:key];
    NSString *encryptStr = [XYSecurityUtility encodeBase64DataToString:resultData];
    NSLog(@"Encrypt str=%@",encryptStr);
    return encryptStr;
}

// 解密方法
+ (NSString*)decryptUseAES:(NSString*)encryptText key:(NSString *)key {
    NSLog(@"Encrypt str=%@",encryptText);
    NSData *data = [XYSecurityUtility decodeBase64StringToData:encryptText];
    NSString *decryptStr = [XYSecurityUtility decryptAESData:data key:key];
    NSLog(@"Decrypt str=%@",decryptStr);
    return decryptStr;
}

// DES encrypt
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key
{
    key = [NSString stringWithFormat:@"%@%@",key,DEFAULT_SECRET];
    key = [key substringToIndex:24];
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = (uint8_t *)malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [DEFAULT_IV UTF8String];
    
    ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [GTMBase64 stringByEncodingData:myData];
    free(bufferPtr);
    return result;
}


// DES decrypt
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key
{
    key = [NSString stringWithFormat:@"%@%@",key,DEFAULT_SECRET];
    key = [key substringToIndex:24];
    NSData *encryptData = [GTMBase64 decodeData:[cipherText dataUsingEncoding:NSUTF8StringEncoding]];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = (uint8_t *)malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [DEFAULT_IV UTF8String];
    
    ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    free(bufferPtr);
    return result;
}


+ (NSString *)encrypt:(NSString*)plainText key: (NSString *)key
{
    return [XYSecurityUtility encryptUseDES:plainText key:key];
}

+ (NSString *)decrypt:(NSString*)encryptText key:(NSString *)key
{
    return [XYSecurityUtility decryptUseDES:encryptText key:key];
}
@end
