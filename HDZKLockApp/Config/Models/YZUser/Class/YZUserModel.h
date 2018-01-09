//
//  YZUserModel.h
//  Demo
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YZMacro.h>
#import "YZUserMacro.h"
#define YZUserModelInstance [YZUserModel sharedInstance]

@interface YZUserModel : NSObject
//用户昵称
@property (nonatomic,copy) NSString *u_nick_name;

//头像
@property (nonatomic,copy) NSString *u_head_url;

//用户 uid
@property (nonatomic,copy) NSString *u_id;

@property  (nonatomic,copy) NSString *openid;
//手机号码
@property (nonatomic,copy) NSString *bind_phone;
//开锁密码
@property (nonatomic,copy) NSString *unlock_password;


/*
//性别
@property (nonatomic,assign) NSInteger u_sex;
//体重
@property (nonatomic,assign) NSInteger u_weight;
//身高
@property (nonatomic,assign) NSInteger u_height;
//出生日期
@property (nonatomic,copy) NSString *u_birth;
//邮箱
@property (nonatomic,copy) NSString *bind_eamil;
//微信唯一标示
@property (nonatomic,copy) NSString *bind_wx;
//QQ唯一标示
@property (nonatomic,copy) NSString *bind_qq;
//微博唯一标示
@property (nonatomic,copy) NSString *bind_wb;
//个性签名
@property (nonatomic,copy) NSString *signature;
*/


SingletonH

/**
 判断是否登录过 登录过调用自动登录接口 否则调用登录接口

 @return 是否登录过
 */
-(BOOL)isLogin;



/**
 判断是否设置过密码

 @return 否设置过密码
 */
-(BOOL)isPassword;

/**
  设置域名和版本

 @param domain 域名
 @param versionType 版本
 @param isHttps 是否是HTTPS请求
 */
-(void)setDomain:(NSString *)domain
     versionType:(YZUserVersionType)versionType
          isHttps:(BOOL)isHttps;



/**
 设置头像上传地址

 @param url 地址
 */
-(void)setHeadUrl:(NSString *)url;

/**
 发生验证码

 @param operation 操作类型
 @param name 用户名(手机或者邮箱)
 @param type 用户类型
 @param success 成功
 @param failure 失败
 */
-(void)sendVerificationCodeWithOperation:(YZAuthCodeOperation)operation
                                    name:(NSString *)name
                                    type:(YZUserType)type
                                 success:(YZSendVerificationCodeSuccess)success
                                 failure:(YZUserFailure)failure;



/**
 验证码登录

 @param code 验证码
 @param name 用户名(手机或者邮箱)
 @param type 用户类型
 @param success 成功
 @param failure 失败
 */
-(void)loginWithCode:(NSString *)code
                name:(NSString *)name
                type:(YZUserType)type
             success:(YZLoginSuccess)success
             failure:(YZUserFailure)failure;



/**
 密码登录

 @param password 密码(加密后)
 @param name     用户名(手机或者邮箱)
 @param type     用户类型
 @param success  成功
 @param failure  失败
 */
-(void)loginWithPassword:(NSString *)password
                    name:(NSString *)name
                    type:(YZUserType)type
                 success:(YZLoginSuccess)success
                 failure:(YZUserFailure)failure;
/**
 手机注册

 @param code     验证码
 @param password 密码(加密后)
 @param name     用户名
 @param type     用户类型
 @param success  成功
 @param failure  失败
 */
-(void)registerWithCode:(NSString *)code
               password:(NSString *)password
                   name:(NSString *)name
                   type:(YZUserType)type
                success:(YZLoginSuccess)success
                failure:(YZUserFailure)failure;



/**
 重置密码

 @param code     验证密码
 @param password 密码(加密后)
 @param name     用户名
 @param type     用户类型
 @param success  成功
 @param failure  失败
 */
-(void)resetPasswordCode:(NSString *)code
                password:(NSString *)password
                    name:(NSString *)name
                    type:(YZUserType)type
                 success:(YZLoginSuccess)success
                 failure:(YZUserFailure)failure;



/**
 修改密码

 @param password    新密码
 @param oldPassword 旧密码
 @param success     成功
 @param failure     失败
 */
-(void)editPassword:(NSString *)password
        oldPassword:(NSString *)oldPassword
            success:(YZLoginSuccess)success
            failure:(YZUserFailure)failure;

/**
 第三方登录

 @param appid 微信 AppID 或者 QQ AppID
 @param secret 微信 AppSecret 或者 QQ Appkey
 @param openid 微信或者 QQ 用户唯一标示
 @param type 登录方式
 @param success 成功
 @param failure 失败
 */
-(void)thirdLoginWithAppid:(NSString *)appid
                    secret:(NSString *)secret
                    openid:(NSString *)openid
                      type:(YZThirdType)type
                   success:(YZLoginSuccess)success
                   failure:(YZUserFailure)failure;


/**
 第三方注册

 @param appid 微信 AppID 或者 QQ AppID
 @param secret 微信 AppSecret 或者 QQ Appkey
 @param openid 微信或者 QQ 用户唯一标示
 @param type 登录方式
 @param phone 手机号码
 @param code 验证码
 @param success 成功
 @param failure 失败
 */
-(void)thirdRegisterWithAppid:(NSString *)appid
                       secret:(NSString *)secret
                       openid:(NSString *)openid
                         type:(YZThirdType)type
                        phone:(NSString *)phone
                         code:(NSInteger)code
                      success:(YZLoginSuccess)success
                      failure:(YZUserFailure)failure;





/**
 自动登录

 @param success 成功
 @param failure 失败
 */
-(void)autoLoginWithSuccess:(YZLoginSuccess)success
                    failure:(YZUserFailure)failure;


/**
 登出

 @param success 登出成功
 */
-(void)loginoutWithSuccess:(YZLogoutSuccess)success;


/**
 用户信息修改

 @param model 用户模型
 @param success 成功
 @param failure 失败
 */
-(void)editUserWithModel:(YZUserModel *)model
                 success:(YZUserEditSuccess)success
                 failure:(YZUserFailure)failure;


/**
 获取用户信息

 @param success 成功
 @param failure 失败
 */
-(void)gainUserWithSuccess:(YZGainUserSuccess)success
                   failure:(YZUserFailure)failure;


/**
 绑定手机账户和邮箱

 @param name 手机账户和邮箱
 @param type 用户类型
 @param code 验证码
 @param success 成功
 @param failure 失败
 */
-(void)bindEmailAndPhoneWithName:(NSString *)name
                            type:(YZUserType)type
                            code:(NSInteger)code
                         success:(YZBindEmailAndPhoneSuccess)success
                         failure:(YZUserFailure)failure;



/**
 绑定第三方账号

 @param type 第三方账号类型
 @param appid 微信 AppID 或者 QQ AppID
 @param secret 微信 AppSecret 或者 QQ Appkey
 @param openid 微信或者 QQ 用户唯一标示
 @param success 成功
 @param failure 失败
 */
-(void)bindThirdWithType:(YZThirdType)type
                   appid:(NSString *)appid
                  secret:(NSString *)secret
                  openid:(NSString *)openid
                 success:(YZBindThirdSuccess)success
                 failure:(YZUserFailure)failure;



/**
 上传位置信息

 @param lg 经度
 @param la 纬度
 @param country 国家
 @param province 省份
 @param city 城市
 @param area 区域
 @param success 成功
 @param failure 失败
 */
-(void)updateLocationWithLg:(float)lg
                         la:(float)la
                    country:(NSString *)country
                   province:(NSString *)province
                       city:(NSString *)city
                       area:(NSString *)area
                    success:(YZUpdateLocationSuccess)success
                    failure:(YZUserFailure)failure;



/**
 上传头像
 @param fileData 头像数据
 @param suffix 文件后缀名
 @param success 成功
 @param failure 失败
 */
-(void)updateHeadData:(NSData *)fileData
               suffix:(NSString *)suffix
              success:(void(^)(NSString *fileUrl))success
              failure:(YZUserFailure)failure;

/**
 上传头像
 
 @param headImage 头像数据
 @param suffix 文件后缀名
 @param success 成功
 @param failure 失败
 */
-(void)updateHeadImage:(UIImage *)headImage
                suffix:(NSString *)suffix
                     success:(void(^)(NSString *fileUrl))success
                     failure:(YZUserFailure)failure;

/**
 验证登录

 @param failure 失败
 */
-(void)checkScodeWithFailure:(YZUserFailure)failure;


/**
  获取上传文件token

 @param suffix 文件后缀名
 @param success 成功
 @param failure 失败
 */
-(void)gainUpdateFileWithSuffix:(NSString *)suffix
                        success:(void(^)(id obj))success
                         failure:(YZUserFailure)failure;
/**
 上传文件

 @param fileData 文件Data
 @param suffix 文件后缀名
 @param success 成功
 @param failure 失败
 */
-(void)updateFileData:(NSData *)fileData
                  key:(NSString *)key
               suffix:(NSString *)suffix
              success:(void(^)(NSString *fileUrl))success
              failure:(YZUserFailure)failure;






@end
