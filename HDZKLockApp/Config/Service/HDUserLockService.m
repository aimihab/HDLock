//
//  HDUserLockService.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDUserLockService.h"
#import "YZNetManager.h"
#import <YYModel.h>
#import "HDZKUserService.h"

#import "HDZKAuthorUserModel.h"
#import "HDZKBeAuthorLockModel.h"
#import "HDZKLockModel.h"

#import "HDZKUserData.h"

@implementation HDUserLockService


+ (void)bindLockWithDevID:(NSString *)devid DevMac:(NSString *)mac DevModel:(NSString *)model DevName:(NSString *)name CheckCode:(NSString *)code Success:(CoreSuccess)success Failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVID:devid,DEVMAC:mac,DEVMODEL:model,DEVNAME:name, CHECKCODE:code};
    
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"bind"];
    
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}

+ (void)authoriseUserWithUid:(NSInteger)uid userName:(NSString *)name authorType:(NSInteger)type devBindID:(NSString *)bindId endTime:(NSString *)endTime isSync:(NSInteger)is_sync success:(CoreSuccess)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),AUTHORUSERID:@(uid),AUTHORUSERNAME:name,AUTHORTYPE:@(type),DEVBINDID:bindId,ENDTIME:endTime,ISSYNC:@(is_sync)};
    
     NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"authorized"];
    
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}



+ (void)gainBindLockListSuccess:(CoreSuccess)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE)};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"get-bind"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            
            NSArray *list = [NSArray arrayWithArray:responseObject[@"list"]];
            [HDZKUserDataInstance updateBandLockListCacheWith:list];//更新缓存
            success(list);
            
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}


+ (void)gainAuthoriseUsersWithDevid:(NSString *)bind_id success:(CoreSuccess)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVBINDID:bind_id};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"get-authorized-list"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}


+ (void)modifyDevAuthoriseUserInfoWithAuthoriseModel:(HDZKAuthorUserModel *)authorizedModel success:(CoreSuccess)success failure:(CoreFailure)failure{
    
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),AUTHORIZEDID:@(authorizedModel.id),AUTHORUSERNAME:authorizedModel.target_name,AUTHORTYPE:@(authorizedModel.bind_type),ENDTIME:authorizedModel.end_time};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"edit-authorized"];
    
    
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
    
}

+ (void)cancelDevAuthorisedWithID:(NSString *)authorized_id success:(CoreSuccess)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),AUTHORIZEDID:authorized_id};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"disable-authorized"];
    
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
}



+ (void)modfiyDevLockNameWithModel:(HDZKLockModel *)model success:(CoreSuccess)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVBINDID:@(model.id),DEVNAME:model.dev_name,CHECKCODE:@(model.password)};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"change-name"];
    
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    

}


+ (void)gainUserbeAuthorisedDevlockListSuccess:(CoreSuccess)success failure:(CoreFailure)failure{
    
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE)};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"authorized-list"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject[DATA]);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}

+ (void)unbindDevlockWithBindID:(NSString *)bind_id success:(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVBINDID:bind_id};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"unbind-lock"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success();
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}

+ (void)syncAuthorisedIDs:(NSString *)ids toServerSuccess:(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),AUTHORIDS:ids};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"set-sync"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success();
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}

+ (void)assignmentAdministratorToUser:(NSString *)uid WithBindLock:(NSString *)lockid success:(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),TRANSFERID:uid,DEVBINDID:lockid};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"change-admin"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success();
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}


+ (void)sendNoticeToUser:(NSString *)targetId Type:(NSInteger)type PhoneIMEI:(NSString *)imei LockName:(NSString *)lock_name authType:(NSInteger)authType Success:(CoreEmptyCallBack)success Failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),TARGETUSERID:targetId,@"type":@(type),@"imei":imei,@"lock_name":lock_name,@"authType":@(authType)};
    NSString *url = [HDZKUserService gainUrlWithModule:BIND method:@"notice-user"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success();
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    

}


+ (void)requestRemoteServertoUnlockWithBindId:(NSInteger)bind_id AuthotizedId:(NSInteger)authorized_id Type:(NSInteger)type Success:(CoreEmptyCallBack)success Failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVBINDID:@(bind_id),AUTHORIZEDID:@(authorized_id),@"type":@(type)};
    NSString *url = [HDZKUserService gainUrlWithModule:UNLOCK method:@"unlock"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 200) {
            DLog(@"请求成功..")
            success(responseObject);
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
    
}


@end
