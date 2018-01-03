//
//  YZUserError.m
//  Demo
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "YZUserError.h"
#import <YZMacro.h>
@implementation YZUserError

-(instancetype)initWithErrorCode:(YZUserErrorCode)code
{
    NSString *description  = @"";
    switch (code) {
        case YZUserErrorCodeNoNetwork:
            description = YZLocalizedString(@"无网络");
            break;
        case YZUserErrorCodeAgainLogin:
            description = YZLocalizedString(@"重新登录");
            break;
        case YZUserErrorCodePhone:
            description = YZLocalizedString(@"请输入正确手机号码");
            break;
        case YZUserErrorCodeEmail:
            description  = YZLocalizedString(@"请输入正确邮箱");
            break;
        case YZUserErrorCodeAuthCodeError:
            description = YZLocalizedString(@"验证码错误");
            break;
        case YZUserErrorCodeAuthCodeOfen:
            description = YZLocalizedString(@"10分钟后在发生验证码");
            break;
        case YZUserErrorCodeBindFailure:
            description = YZLocalizedString(@"第三方账号绑定失败");
            break;
        case YZUserErrorCodeBindWxFailure:
            description = YZLocalizedString(@"微信已被绑定");
            break;
        case YZUserErrorCodeBindQQFailure:
            description = YZLocalizedString(@"QQ已被绑定");
            break;
        case YZUserErrorCodeBindWbFailure:
            description = YZLocalizedString(@"微博已被绑定");
            break;
        case YZUserErrorCodeThirdLoginFailure:
            description = YZLocalizedString(@"第三方登录失败,需要进行第三方注册");
            break;
        case YZUserErrorCodeUnkonowFailure:
            description = YZLocalizedString(@"未知错误");
            break;
        default:
            break;
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    if (self = [super initWithDomain:@"com.szbailiao.user" code:code userInfo:userInfo]) {
        
    }
    return self;
}

-(instancetype)initWithErrorCode:(YZUserErrorCode)code withdescription:(NSString *)description
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    if (self = [super initWithDomain:@"com.szbailiao.user" code:code userInfo:userInfo]) {
        
    }
    return self;
}



@end
