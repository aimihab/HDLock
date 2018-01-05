//
//  YZUserModel.m
//  Demo
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "YZUserModel.h"
#import "YZNetManager.h"

#import <NSString+YZ.h>

#import <NSString+EncryptSha.h>
#import <YYModel.h>
#import <JSONKit.h>

#import <QiniuSDK.h>

static NSString *QINIUURL = @"http://oqjjvo9tz.bkt.clouddn.com/";
@implementation YZUserModel
{
    NSString *scode_;  //通信秘钥
    NSString *domain_;  //域名
    YZUserVersionType versionType_; //版本
    BOOL isHttps_;
    NSString *token_;
}
SingletonM


-(instancetype)init
{
    if (self = [super init]) {
       scode_ = YZ_UDGetObj(SCODE);
    }
    return self;
}
#pragma mark --------------public method----------------

-(BOOL)isLogin
{
    if (scode_) {
        return true;
    }else
    {
        return false;
    }
}


-(BOOL)isPassword
{
    NSInteger is_password = [YZ_UDGetObj(ISPASSWORD) integerValue];
    if (is_password) {
        return true;
    }else
    {
        return false;
    }
}

-(void)setDomain:(NSString *)domain versionType:(YZUserVersionType)versionType isHttps:(BOOL)isHttps
{
    domain_ = domain;
    versionType_ = versionType;
    isHttps_ = isHttps;
    YZ_UDSetObj(domain_,YZDOMAIN);
    NSString *user = YZ_UDGetObj(USER);
    if (user) {
        YZUserModel *model = [YZUserModel yy_modelWithJSON:user];

        self.bind_phone = model.bind_phone?model.bind_phone:@"";
        self.u_id = model.u_id?model.u_id:@"";
        self.openid = model.openid?model.openid:@"";
        self.u_head_url = model.u_head_url?model.u_head_url:@"";
        self.u_nick_name = model.u_nick_name?model.u_nick_name:@"";
        self.u_id = model.u_id?model.u_id:@"";
        self.unlock_password = model.unlock_password?model.unlock_password:@"";
        /*
        self.u_sex = model.u_sex;
        self.u_birth = model.u_birth?model.u_birth:@"";
        self.u_height = model.u_height;
        self.u_weight = model.u_weight;
        self.bind_qq = model.bind_qq?model.bind_qq:@"";
        self.bind_wx = model.bind_wx?model.bind_wx:@"";
        self.bind_eamil = model.bind_eamil?model.bind_eamil:@"";
        self.bind_wb = model.bind_wb?model.bind_wb:@"";
        self.signature = model.signature?model.signature:@"";
        */
    }
}


-(void)setHeadUrl:(NSString *)url
{
    QINIUURL = url;
}



#pragma mark -----发生验证码----
-(void)sendVerificationCodeWithOperation:(YZAuthCodeOperation)operation name:(NSString *)name type:(YZUserType)type success:(YZSendVerificationCodeSuccess)success failure:(YZUserFailure)failure
{
    //删除验证码MD5值
    YZ_UDDeleteObj(MD5);
    switch (type) {
        case YZUserTypePhone:
            if (![NSString isMobileNumber:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                    failure(error);
                }
                return;
            }
            break;
        case YZUserTypeEmail:
            if (![NSString isEmail:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeEmail];
                    failure(error);
                }
                return;
            }
            break;
            
        default:
            break;
    }
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"auth-code"];
    NSDictionary *param = @{NAME:name,OPERATION:@(operation),TYPE:@(type)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSArray *keys = [dataDic allKeys];
            NSString *authCode = @"0000";
            if ([keys containsObject:AUTHCODE]) {
                authCode = [NSString stringWithFormat:@"%@",dataDic[AUTHCODE]];
            }
            if ([keys containsObject:MD5]) {
                YZ_UDSetObj(responseObject[MD5],MD5);
            }
            if (success) {
                success(authCode);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}

#pragma mark ---  验证码登录

-(void)loginWithCode:(NSString *)code name:(NSString *)name type:(YZUserType)type success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    switch (type) {
        case YZUserTypePhone:
            if (![NSString isMobileNumber:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                    failure(error);
                }
                return;
            }
            break;
        case YZUserTypeEmail:
            if (![NSString isEmail:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeEmail];
                    failure(error);
                }
                return;
            }
            break;
            
        default:
            break;
    }
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"login"];
    NSDictionary *param = @{AUTHCODE:code,NAME:name,TYPE:@(1)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:DATA]) {
                NSDictionary *user = responseObject[DATA];
                scode_ = user[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
                [self p_analysisUser:user];//给用户模型赋值
                
                if ([[user allKeys] containsObject:@"has_password"]) {
                    NSInteger isPassword = [user[@"has_password"] integerValue];
                     YZ_UDSetObj(@(isPassword),ISPASSWORD);
                    if (isPassword == 0) {
                        if (success) {
                            success(false);
                        }
                    }else
                    {
                        if (success) {
                            success(true);
                        }
                    }
                }else
                {
                    if (success) {
                        success(true);
                    }
                }
            }else
            {
                if (success) {
                    success(true);
                }
                
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
          [self p_analysisError:error failure:failure];
    }];
}


#pragma mark ------ 密码登录

-(void)loginWithPassword:(NSString *)password name:(NSString *)name type:(YZUserType)type success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    switch (type) {
        case YZUserTypePhone:
            if (![NSString isMobileNumber:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                    failure(error);
                }
                return;
            }
            break;
        case YZUserTypeEmail:
            if (![NSString isEmail:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeEmail];
                    failure(error);
                }
                return;
            }
            break;
            
        default:
            break;
    }
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"login"];
    NSDictionary *param = @{@"password":password,NAME:name,TYPE:@(2)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
    
            if ([keys containsObject:DATA]) {
                NSDictionary *user = responseObject[DATA];
                scode_ = responseObject[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
                [self p_analysisUser:user];
            }
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}


#pragma mark --- 手机注册

-(void)registerWithCode:(NSString *)code password:(NSString *)password name:(NSString *)name type:(YZUserType)type success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    switch (type) {
        case YZUserTypePhone:
            if (![NSString isMobileNumber:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                    failure(error);
                }
                return;
            }
            break;
        case YZUserTypeEmail:
            if (![NSString isEmail:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeEmail];
                    failure(error);
                }
                return;
            }
            break;
            
        default:
            break;
    }
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"register"];
    NSDictionary *param = @{@"password":password,@"phone":name,AUTHCODE:code};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:SCODE]) {
                scode_ = responseObject[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
            }
            if ([keys containsObject:DATA]) {
                NSDictionary *user = responseObject[USER];
                [self p_analysisUser:user];
            }
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}



#pragma mark --- 重置密码

-(void)resetPasswordCode:(NSString *)code password:(NSString *)password name:(NSString *)name type:(YZUserType)type success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    switch (type) {
        case YZUserTypePhone:
            if (![NSString isMobileNumber:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                    failure(error);
                }
                return;
            }
            break;
        case YZUserTypeEmail:
            if (![NSString isEmail:name]) {
                if (failure) {
                    YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeEmail];
                    failure(error);
                }
                return;
            }
            break;
            
        default:
            break;
    }
    NSString *url = [self gainUrlWithModule:USER method:@"reset-password"];
    NSDictionary *param = @{@"password":password,@"phone":name,AUTHCODE:code}
    ;
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            YZ_UDSetObj(@(1),ISPASSWORD);
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}


#pragma mark --- 修改密码

-(void)editPassword:(NSString *)password oldPassword:(NSString *)oldPassword success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
     [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:USER method:@"change-password"];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{SCODE:scode_,OPENID:self.openid,@"password":password}];
    if (oldPassword && [oldPassword isEqualToString:@""]) {
        [param setObject:oldPassword forKey:@"oldPassword"];
    }
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            YZ_UDSetObj(@(1),ISPASSWORD);
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}

#pragma mark ------第三方登录
-(void)thirdLoginWithAppid:(NSString *)appid secret:(NSString *)secret openid:(NSString *)openid type:(YZThirdType)type success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"third-login"];
    NSDictionary *param = @{OPENID:openid,SECRET:secret,APPID:appid,TYPE:@(type)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:SCODE]) {
                scode_ = responseObject[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
            }
            if ([keys containsObject:DATA]) {
                [self p_analysisUser:responseObject[DATA]];
            }
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
          [self p_analysisError:error failure:failure];
    }];
}


#pragma mark ---------- 第三方注册

-(void)thirdRegisterWithAppid:(NSString *)appid secret:(NSString *)secret openid:(NSString *)openid type:(YZThirdType)type phone:(NSString *)phone code:(NSInteger)code success:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    //检查手机格式
    if (![NSString isMobileNumber:phone]) {
        if (failure) {
            YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
            failure(error);
        }
        return;
    }
    //检查验证码
    NSString *md5 = YZ_UDGetObj(MD5);
    if (md5) {
        NSString *authCode = [NSString stringWithFormat:@"%ld",(long)code];
        if (![[authCode md5] isEqualToString:md5]) {
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAuthCodeError];
                failure(error);
            }
            return;
        }
    }
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"third-register"];
    NSDictionary *param = @{OPENID:openid,SECRET:secret,APPID:appid,TYPE:@(type),PHONE:phone,AUTHCODE:@(code)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
     
            if ([keys containsObject:DATA]) {
                
                [self p_analysisUser:responseObject[DATA]];
                scode_ = responseObject[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
            }
            if (success) {
                success(true);
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];

    
    
}

#pragma mark -------自动登录
-(void)autoLoginWithSuccess:(YZLoginSuccess)success failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"auto-login"];
    NSDictionary *param = @{SCODE:scode_,OPENID:self.openid};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:SCODE]) {
                scode_ = responseObject[SCODE];
                YZ_UDSetObj(scode_, SCODE); //存储
            }
            if ([keys containsObject:DATA]) {
                [self p_analysisUser:responseObject[DATA]];
            }
            if (success) {
                success(true);
            }
            
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}

#pragma mark -------登出

-(void)loginoutWithSuccess:(YZLogoutSuccess)success
{
    [self checkScodeWithFailure:^(YZUserError *error) {
        if (success) {
            success();
        }
    }];
    NSString *url = [self gainUrlWithModule:LOGINMODULE method:@"logout"];
    NSDictionary *param = @{SCODE:scode_,OPENID:self.openid};
    [YZNetManager networkPostRequestWithParameter:param url:url success:nil failure:nil];
     YZ_UDDeleteObj(SCODE);
     scode_ = nil;
    if (success) {
        success();
    }
}



#pragma mark --------用户信息修改

-(void)editUserWithModel:(YZUserModel *)model success:(YZUserEditSuccess)success failure:(YZUserFailure)failure
{
     [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:USERMODULE method:@"user-edit"];
    NSDictionary *param = @{SCODE:scode_,NICKNAME:model.u_nick_name,HEADURL:model.u_head_url,OPENID:self.openid,UNLOCK_PASSWORD:model.unlock_password};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:DATA]) {
                [self p_analysisUser:responseObject[DATA]];
            }
            if (success) {
                success();
            }
            
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}



#pragma mark --------获取用户信息

-(void)gainUserWithSuccess:(YZGainUserSuccess)success failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:USERMODULE method:@"user-info"];
    NSDictionary *param = @{SCODE:scode_,OPENID:self.openid};
    [YZNetManager networkGetRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:DATA]) {
                [self p_analysisUser:responseObject[DATA]];
            }
            if (success) {
                success();
            }
            
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}

#if 0
#pragma mark -------- 绑定手机账户和邮箱
-(void)bindEmailAndPhoneWithName:(NSString *)name type:(YZUserType)type code:(NSInteger)code success:(YZBindEmailAndPhoneSuccess)success failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:USERMODULE method:@"bind"];
    NSDictionary *param = @{SCODE:scode_,OPENID:self.openid,NAME:name,TYPE:@(type),AUTHCODE:@(code)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            switch (type) {
                case YZUserTypePhone:
                    self.bind_phone = name;
                    break;
                case YZUserTypeEmail:
                    self.bind_eamil = name;
                    break;
                default:
                    break;
            }
            NSString *json = [self yy_modelToJSONString];
            YZ_UDSetObj(json,DATA);
            if (success) {
                success();
            }
            
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}


#pragma mark ------- 绑定第三方账号

-(void)bindThirdWithType:(YZThirdType)type appid:(NSString *)appid secret:(NSString *)secret openid:(NSString *)openid success:(YZBindThirdSuccess)success failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url =  [self gainUrlWithModule:USERMODULE method:@"bind"];
    NSDictionary *param = @{OPENID:openid,SECRET:secret,APPID:appid,TYPE:@(type+2)};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            switch (type) {
                case YZThirdTypeWX:
                    self.bind_wx = openid;
                    break;
                case YZThirdTypeQQ:
                    self.bind_qq = openid;
                    break;
                case YZThirdTypeWB:
                    self.bind_wb = openid;
                    break;
                default:
                    break;
            }
            NSString *json = [self yy_modelToJSONString];
            YZ_UDSetObj(json,DATA);
            if (success) {
                success();
            }
            
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}


#pragma mark ------- 上传位置信息

-(void)updateLocationWithLg:(float)lg la:(float)la country:(NSString *)country province:(NSString *)province city:(NSString *)city area:(NSString *)area success:(YZUpdateLocationSuccess)success failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url =  [self gainUrlWithModule:USERMODULE method:@"add-history"];
    NSUUID *uuidObj = [UIDevice currentDevice].identifierForVendor;
    NSString *phoneid = uuidObj.UUIDString;
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    NSString *phoneos = [NSString stringWithFormat:@"iOS%@",sysVersion];
    NSDictionary *param = @{LA:@(la),LG:@(lg),COUNTRY:country,PROVINCE:province,CITY:city,AREA:area,OS:phoneos,DEVICE:phoneid};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
           if (success) {
                success();
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
    
}

#endif

#pragma mark --- 上传头像
-(void)updateHeadData:(NSData *)fileData suffix:(NSString *)suffix success:(void (^)(NSString *))success failure:(YZUserFailure)failure
{
    NSString *key = [NSString stringWithFormat:@"%@.%@",self.u_id,suffix];
    [self updateFileData:fileData key:key suffix:suffix success:^(NSString *fileUrl) {
        YZUserModelInstance.u_head_url = fileUrl;
        if (success) {
            success(fileUrl);
        }
    } failure:failure];
}


#pragma mark --- 上传头像
-(void)updateHeadImage:(UIImage *)headImage suffix:(NSString *)suffix success:(void (^)(NSString *))success failure:(YZUserFailure)failure

{
     NSData *data = UIImageJPEGRepresentation(headImage,1.0);
    [self updateHeadData:data suffix:suffix success:success failure:failure];
    
}

#pragma mark -------上传文件

-(void)updateFileData:(NSData *)fileData key:(NSString *)key suffix:(NSString *)suffix success:(void (^)(NSString *))success failure:(YZUserFailure)failure
{
    
    
    [self gainUpdateFileWithSuffix:suffix success:^(NSString *token) {
            [self p_updateFileData:fileData key:key token:token success:success failure:failure];
        } failure:failure];
}



#pragma mark ---检查scode---
-(void)checkScodeWithFailure:(YZUserFailure)failure
{
    if ((!scode_ || [scode_ isEqualToString:@""])) {
        if (failure) {
            YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAgainLogin];
            failure(error);
            return;
        }
    }
    
    if (!self.openid || [self.openid isEqualToString:@""]) {
        if (failure) {
            YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAgainLogin];
            failure(error);
            return;
        }
        
    }
}

#pragma mark ------获取上传文件token
-(void)gainUpdateFileWithSuffix:(NSString *)suffix success:(void (^)(NSString *))success  failure:(YZUserFailure)failure
{
    [self checkScodeWithFailure:failure];
    NSString *url = [self gainUrlWithModule:UPLODMODULE method:@"get-sdk-token"];
    NSDictionary *param = @{SCODE:scode_,OPENID:self.openid,SUFFIX:suffix};
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        [self p_analysisResponseObject:responseObject success:^(id responseObject) {
            NSArray *keys = [responseObject allKeys];
            if ([keys containsObject:TOKEN]) {
                if (success) {
                    NSString *token = responseObject[TOKEN];
                    success(token);
                }
            }
        } failure:failure];
    } failure:^(YZNetError *error) {
        [self p_analysisError:error failure:failure];
    }];
}

#pragma mark ----------private method---------------


#pragma mark ------上传文件私有方法

-(void)p_updateFileData:(NSData *)fileData  key:(NSString *)key token:(NSString *)token success:(void (^)(NSString *))success failure:(YZUserFailure)failure
{
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = [QNFixedZone zone2];
    }];
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    [upManager putData:fileData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (info.ok && success) {
            NSString *url =[NSString stringWithFormat:@"%@%@",QINIUURL,resp[@"key"]];
            success(url);
        }
        
    } option:nil];
}

#pragma mark ----解析错误信息
-(void)p_analysisError:(YZNetError *)error failure:(YZUserFailure)failure
{
    
    
    if (failure) {
         YZUserError *userError = [[YZUserError alloc] initWithErrorCode:error.code withdescription:error.localizedDescription];
        failure(userError);
    }
}

#pragma mark ----解析responseObject信息
-(void)p_analysisResponseObject:(id)responseObject success:(void(^)(id responseObject))success failure:(YZUserFailure)failure
{
     NSInteger code = [responseObject[CODE] integerValue];
    switch (code) {
        case 200:
            if (success) {
                success(responseObject);
            }
            break;
        case 2001:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodePhone];
                failure(error);
            }
            break;
        case 2002:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAuthCodeError];
                failure(error);
            }
            break;
        case 2003:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAuthCodeOfen withdescription:responseObject[@"msg"]];
                failure(error);
            }
            break;
        case 2004:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAgainLogin];
                failure(error);
            }
            break;
        case 2005:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeBindFailure];
                failure(error);
            }
            break;
        case 2006:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeThirdLoginFailure];
                failure(error);
            }
            break;
        case 3005:
        case 3006:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeAuthCodeOfen withdescription:responseObject[@"msg"]];
                failure(error);
            }
            break;
        default:
            if (failure) {
                YZUserError *error = [[YZUserError alloc] initWithErrorCode:YZUserErrorCodeUnkonowFailure];
                failure(error);
            }
            break;
    }
    
}

-(void)p_analysisUser:(NSDictionary *)user
{
    YZUserModel *model = [YZUserModel yy_modelWithDictionary:user];
    if (model) {
        
        YZUserModelInstance.bind_phone = model.bind_phone?model.bind_phone:@"";
        YZUserModelInstance.openid = model.openid?model.openid:@"";
        YZUserModelInstance.u_id = model.u_id?model.u_id:@"";
        YZUserModelInstance.u_head_url = model.u_head_url?model.u_head_url:@"";
        YZUserModelInstance.u_nick_name = model.u_nick_name?model.u_nick_name:@"";
        YZUserModelInstance.unlock_password = model.unlock_password?model.unlock_password:@"";
       
        /*
        YZUserModelInstance.u_sex = model.u_sex;
        YZUserModelInstance.bind_qq = model.bind_qq?model.bind_qq:@"";
        YZUserModelInstance.bind_wx = model.bind_wx?model.bind_wx:@"";
        YZUserModelInstance.bind_eamil = model.bind_eamil?model.bind_eamil:@"";
        YZUserModelInstance.bind_wb = model.bind_wb?model.bind_wb:@"";
        YZUserModelInstance.u_birth = model.u_birth?model.u_birth:@"";
        YZUserModelInstance.signature = model.signature?model.signature:@"";
        YZUserModelInstance.u_height = model.u_height;
        YZUserModelInstance.u_weight = model.u_weight;
        */
        NSString *json = [YZUserModelInstance yy_modelToJSONString];
        YZ_UDSetObj(json,USER);
    }
}


-(NSString *)gainUrlWithModule:(NSString *)module method:(NSString *)method
{
    NSString *url = @"";
    
    NSString *http = @"http://";
    if (isHttps_) {
        http = @"https://";
    }
    switch (versionType_) {
        case YZUserVersionTypeTest:
        {
            url = [NSString stringWithFormat:@"%@%@/%@/%@/%@",http,domain_,module,USERAPIVERION,method];
        }
            break;
            
        default:
        {
              url = [NSString stringWithFormat:@"%@%@.%@/%@/%@",http,module,domain_,USERAPIVERION,method];
        }
            break;
    }
    return url;
}




@end
