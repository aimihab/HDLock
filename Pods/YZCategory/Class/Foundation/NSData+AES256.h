//
//  NSData+AES256.h
//  YZCategory
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)
//加密
-(NSData *)encryptWithKey:(NSString *)key;

//解密
-(NSData *)decryptWithKey:(NSString *)key;
+ (NSString *)AES256EncryptWithPlainText:(NSString *)plain password:(NSString *)password;      /*加密方法,参数需要加密的内容*/
+ (NSString *)AES256DecryptWithCiphertext:(NSString *)ciphertexts password:(NSString *)password; /*解密方法，参数数密文*/

@end
