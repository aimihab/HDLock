//
//  NSString+Hash.h
//  YZCategory
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncryptSha)
//MD5 加密
-(NSString *)md5;
//SHA1 加密
-(NSString *)encryptSha1;

//SHA224 加密
-(NSString *)encryptSha224;

//SHA256 加密
-(NSString *)encryptSha256;

//SHA384 加密
-(NSString *)encryptSha384;

//SHA512 加密
-(NSString *)encryptSha512;


@end
