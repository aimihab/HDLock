//
//  YZUserMacro.h
//  Demo
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#ifndef YZUserMacro_h
#define YZUserMacro_h
#import <Foundation/Foundation.h>
#import <YZMacro.h>
#import "YZUserError.h"

#pragma mark -----常量定义----------------


#pragma mark ---------- 请求字段宏

static NSString  * const SCODE = @"s_code";
static NSString  * const AUTHCODE = @"auth_code";
static NSString  * const OPERATION = @"operation";
static NSString  * const NAME = @"phone";
//锁项目字段
static NSString  * const CODE = @"code";
static NSString  * const DATA = @"data";
static NSString  * const MSG = @"msg";


static NSString  * const TYPE = @"type";
static NSString  * const MD5 = @"md5";
static NSString  * const USER = @"user";

static NSString * const APPID = @"appid";
static NSString * const SECRET = @"secret";
static NSString * const OPENID = @"openid";
static NSString * const PHONE = @"phone";
static NSString * const NICKNAME = @"u_nick_name";
static NSString * const HEADURL = @"u_head_url";
static NSString * const UNLOCK_PASSWORD = @"unlock_password";



/*
static NSString * const SEX = @"u_sex";
static NSString * const HEIGHT = @"u_height";
static NSString * const WEIGHT = @"u_weight";
static NSString * const BIRTH = @"u_birth";
static NSString * const LA = @"la";
static NSString * const LG = @"lg";
static NSString * const COUNTRY = @"country";
static NSString * const PROVINCE = @"province";
static NSString * const CITY = @"city";
static NSString * const AREA = @"area";
*/

static NSString * const OS = @"os";
static NSString * const DEVICE = @"device";
static NSString * const YZDOMAIN = @"yz_domain";
static NSString * const TOKEN = @"token";
static NSString * const SIGNATURE = @"signature";
static NSString * const SUFFIX = @"suffix";


#pragma mark -----------模块宏
static NSString *USERMODULE = @"user";
static NSString *LOGINMODULE = @"login";
static NSString *UPLODMODULE = @"upload";


#pragma mark ----------版本宏

static NSString *USERAPIVERION = @"v1";


#pragma mark ---------是否有设置密码宏
static NSString *ISPASSWORD = @"isPassword";


#pragma mark -----枚举状态定义----------------


///验证码操作类型
typedef NS_ENUM(NSInteger,YZAuthCodeOperation) {
    /// 登录获取验证码
    YZAuthCodeOperationLogin = 1,
};

//用户类型
typedef NS_ENUM(NSInteger,YZUserType) {
//    手机用户
   YZUserTypePhone = 1,
//    邮箱用户
   YZUserTypeEmail,
};


typedef NS_ENUM(NSInteger,YZLoginType) {
    //验证码登录
    YZLoginTypeCode = 1,
    //密码登录
    YZLoginTypePassword,
};



/// 性别
typedef NS_ENUM(NSInteger,YZGenderType) {
    /// 男
    YZGenderTypeMan = 1,
    /// 女
    YZGenderTypeWoman,
    /// 保密
    XQGenderTypeSecret,
};

///第三方登录方式
typedef NS_ENUM (NSInteger,YZThirdType){
    /// 微信
    YZThirdTypeWX = 1,
     /// QQ
    YZThirdTypeQQ,
     /// 微博
    YZThirdTypeWB,
};



typedef NS_ENUM(NSInteger,YZUserVersionType){
    YZUserVersionTypeDevelop = 1,  //开发版本
    YZUserVersionTypeTest,   //测试版本
    YZUserVersionTypeOnline, //上线版本
};


#pragma mark -----Block定义----------------

//发送验证码成功Block
typedef void (^YZSendVerificationCodeSuccess)(NSString *code);
//登录成功Block
typedef void (^YZLoginSuccess)(BOOL hasPassword);
//登出成功Block
typedef void (^YZLogoutSuccess)(void);
//用户信息修改成功Block
typedef void (^YZUserEditSuccess)(void);
//获取个人信息Block
typedef void (^YZGainUserSuccess)(void);
//绑定手机和邮箱
typedef void (^YZBindEmailAndPhoneSuccess)(void);
//绑定第三方账号
typedef void (^YZBindThirdSuccess)(void);
//上传位置信息成功
typedef void (^YZUpdateLocationSuccess)(void);



//失败Block
typedef void (^YZUserFailure)(YZUserError *error);






#endif /* YZUserMacro_h */
