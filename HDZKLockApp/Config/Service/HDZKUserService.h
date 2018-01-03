//
//  HDZKUserService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/7.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HDZKUserService : NSObject


+(NSString *)createHeadUrlWithUName:(NSString *)u_name;

+(NSString *)headUrlWithUserModel:(YZUserModel *)user;



/**
 获取连接地址
 
 @param module  模块
 @param method 方法
 @return 地址
 */
+(NSString *)gainUrlWithModule:(NSString *)module
                        method:(NSString *)method;




/**
 设置域名和版本
 
 @param domain 域名
 @param versionType 版本
 @param isHttps 是否是HTTPS请求
 */
+(void)setDomain:(NSString *)domain
     versionType:(YZUserVersionType)versionType
         isHttps:(BOOL)isHttps;

/**
 判断是否已经登录
 
 @return 是否登录
 */
+(BOOL)isLogin;


/**
 手机登录发生验证码
 
 @param phone 手机号码
 @param success 成功
 @param failure 失败
 */
+(void)loginVerificationCodeWithPhone:(NSString *)phone
                              success:(YZSendVerificationCodeSuccess)success
                              failure:(YZUserFailure)failure;



/**
 重置密码获取验证码
 
 @param phone   手机号
 @param success 成功
 @param failure 失败
 */
+(void)resetPasswordVerificationCodeWithPhone:(NSString *)phone
                                      success:(YZSendVerificationCodeSuccess)success
                                      failure:(YZUserFailure)failure;


/**
 手机验证码登录
 
 @param phone 手机号码
 @param code 验证码
 @param success 成功
 @param failure 失败
 
 */
+(void)loginWithPhone:(NSString *)phone
                 code:(NSString *)code
              success:(YZLoginSuccess)success
              failure:(YZUserFailure)failure;



/**
 密码登录
 
 @param phone   手机号
 @param password 密码(未加密)
 @param success  成功
 @param failure  失败
 */
+(void)loginWithPhone:(NSString *)phone
             password:(NSString *)password
              success:(YZLoginSuccess)success
              failure:(YZUserFailure)failure;


/**
 手机注册
 
 @param code     验证码
 @param password 密码(未加密)
 @param phone     手机号
 @param success  成功
 @param failure  失败
 */
+(void)registerWithCode:(NSString *)code
               password:(NSString *)password
                  phone:(NSString *)phone
                success:(YZLoginSuccess)success
                failure:(YZUserFailure)failure;



/**
 重置密码
 
 @param code     验证密码
 @param password 密码(未加密)
 @param phone    手机号
 @param success  成功
 @param failure  失败
 */
+(void)resetPasswordCode:(NSString *)code
                password:(NSString *)password
                   phone:(NSString *)phone
                 success:(YZLoginSuccess)success
                 failure:(YZUserFailure)failure;



/**
 设置密码
 
 @param password    密码
 @param success     成功
 @param failure     失败
 */
+(void)setPassword:(NSString *)password
           success:(YZLoginSuccess)success
           failure:(YZUserFailure)failure;




+(void)changePasswordWithOldPasswod:(NSString *)oldPassword
                        newPassword:(NSString *)newPassword
                            success:(YZLoginSuccess)success
                            failure:(YZUserFailure)failure;
/**
 自动登录
 
 @param success 成功
 @param failure 失败
 */
+(void)autoLoginWithSuccess:(YZLoginSuccess)success
                    failure:(YZUserFailure)failure;


/**
 登出
 
 @param success 成功
 */
+(void)loginoutWithSuccess:(YZLogoutSuccess)success;

/**
 用户信息修改
 
 @param model 用户模型
 @param success 成功
 @param failure 失败
 */
+(void)editUserWithModel:(YZUserModel *)model
                 success:(YZUserEditSuccess)success
                 failure:(YZUserFailure)failure;






@end
