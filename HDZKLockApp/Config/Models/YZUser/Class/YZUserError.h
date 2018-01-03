//
//  YZUserError.h
//  Demo
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户错误状态码
typedef NS_ENUM (NSInteger,YZUserErrorCode){
    //无网络
    YZUserErrorCodeNoNetwork = 1,
    ///重新登录
    YZUserErrorCodeAgainLogin,
    ///手机号码格式错误
    YZUserErrorCodePhone,
    ///邮箱格式错误
    YZUserErrorCodeEmail,
    ///验证码错误
    YZUserErrorCodeAuthCodeError,
    ///请求验证码频繁
    YZUserErrorCodeAuthCodeOfen,
    ///绑定失败
    YZUserErrorCodeBindFailure,
    ///绑定QQ失败
    YZUserErrorCodeBindQQFailure,
    ///绑定微信失败
    YZUserErrorCodeBindWxFailure,
    ///绑定微博失败
    YZUserErrorCodeBindWbFailure,
    ///第三方登录失败
    YZUserErrorCodeThirdLoginFailure,
    ///未知错误
    YZUserErrorCodeUnkonowFailure,
    
};
@interface YZUserError : NSError
-(instancetype)initWithErrorCode:(YZUserErrorCode)code;

-(instancetype)initWithErrorCode:(YZUserErrorCode)code withdescription:(NSString *)description;
@end
