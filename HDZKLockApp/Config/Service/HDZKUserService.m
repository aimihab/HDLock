//
//  HDZKUserService.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/7.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKUserService.h"

#import <NSString+EncryptSha.h>
#import <NSString+YZ.h>
#import "NSString+Check.h"
#import "HttpMacro.h"

@implementation HDZKUserService


#pragma mark  ############################################
#pragma mark  ------------ public method
#pragma mark  ############################################

+(NSString *)gainUrlWithModule:(NSString *)module method:(NSString *)method
{
    NSString *url = @"";
    NSString *http = @"http://";
#if ISHTTPS
    http = @"https://";
#else
#endif
    url = [NSString stringWithFormat:@"%@%@.%@/%@/%@",http,module,HDDOMAIN,APIVERSION,method];
    return url;
    
}



+(NSString *)createHeadUrlWithUName:(NSString *)u_name
{
    NSString *url = [NSString stringWithFormat:@"%@%@.png",QINIUHEADURL,u_name];;
    return url;
}


+(NSString *)headUrlWithUserModel:(YZUserModel *)user
{
    NSString *url = @"";
    if ([user.u_head_url isHttpUlr] && [user.u_head_url rangeOfString:user.u_id].location != NSNotFound ) {
        url = user.u_head_url;
    }else
    {
        url = [self createHeadUrlWithUName:user.u_id];
    }
    return url;
    
}


#pragma mark --- 设置域名
+(void)setDomain:(NSString *)domain
     versionType:(YZUserVersionType)versionType
         isHttps:(BOOL)isHttps
{
    [YZUserModelInstance setDomain:domain versionType:versionType isHttps:isHttps];
}


#pragma mark ---- 判断是否登录
+(BOOL)isLogin
{
    return [YZUserModelInstance isLogin];
}

#pragma mark --- 登录验证码
+(void)loginVerificationCodeWithPhone:(NSString *)phone success:(YZSendVerificationCodeSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance sendVerificationCodeWithOperation:YZAuthCodeOperationLogin name:phone type:YZUserTypePhone success:success failure:failure];
}


#pragma mark --- 重置密码验证码
+(void)resetPasswordVerificationCodeWithPhone:(NSString *)phone success:(YZSendVerificationCodeSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance sendVerificationCodeWithOperation:YZAuthCodeOperationLogin name:phone type:YZUserTypePhone success:success failure:failure];
}

#pragma mark --- 手机登录
+(void)loginWithPhone:(NSString *)phone code:(NSString *)code success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance loginWithCode:code name:phone type:YZUserTypePhone success:^(BOOL hasPassword) {
        if (success) {
            success(hasPassword);
        }

    } failure:failure];
}


#pragma mark --- 密码登录

+(void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    
    [YZUserModelInstance loginWithPassword:[[password md5] encryptSha512] name:phone type:YZUserTypePhone success:^(BOOL hasPassword){
 
        if (success) {
            success(hasPassword);
        }
        
    } failure:failure];
}

#pragma mark ---  手机注册

+(void)registerWithCode:(NSString *)code password:(NSString *)password phone:(NSString *)phone success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance registerWithCode:code password:[[password md5] encryptSha512] name:phone type:YZUserTypePhone success:^(BOOL hasPassword) {
       

    } failure:failure];
}

#pragma mark ---  重置密码

+(void)resetPasswordCode:(NSString *)code password:(NSString *)password phone:(NSString *)phone success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance resetPasswordCode:code password:[[password md5] encryptSha512]  name:phone type:YZUserTypePhone success:success failure:failure];
}

#pragma mark --- 设置密码

+(void)setPassword:(NSString *)password success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance editPassword:[[password md5] encryptSha512] oldPassword:nil success:success failure:failure];
}


+(void)changePasswordWithOldPasswod:(NSString *)oldPassword newPassword:(NSString *)newPassword success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance editPassword:newPassword oldPassword:oldPassword success:success failure:failure];
}



#pragma mark ---自动登录
+(void)autoLoginWithSuccess:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
  
    [YZUserModelInstance autoLoginWithSuccess:^(BOOL hasPassword){
   
        if (success) {
            success(hasPassword);
        }

    } failure:failure];
}


#pragma mark --- 退出登录
+(void)loginoutWithSuccess:(YZLogoutSuccess)success
{
    [YZUserModelInstance loginoutWithSuccess:^{
     
        if (success) {
            success();
        }
    }];
}

#pragma mark --- 用户信息编辑
+(void)editUserWithModel:(YZUserModel *)model success:(YZUserEditSuccess)success failure:(YZUserFailure)failure
{
    [YZUserModelInstance editUserWithModel:model success:success failure:failure];
}





@end
