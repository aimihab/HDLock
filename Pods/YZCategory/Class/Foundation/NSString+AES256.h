//
//  NSString+AES256.h
//  YZCategory
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256)

//加密
-(NSString *)encryptWithKey:(NSString *)key;

//解密
-(NSString *)decryptWithKey:(NSString *)key;

@end
