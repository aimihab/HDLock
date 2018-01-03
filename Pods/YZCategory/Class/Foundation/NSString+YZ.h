//
//  NSString+YZ.h
//  YZCategory
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YZ)
//验证手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//验证邮箱
+(BOOL)isEmail:(NSString *)email;

@end
