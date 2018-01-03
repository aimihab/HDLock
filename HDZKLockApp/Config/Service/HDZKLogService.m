//
//  HDZKLogService.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLogService.h"
#import "YZNetManager.h"
#import <YYModel.h>
#import "HDZKUserService.h"

#import "HDZKLogModel.h"

@implementation HDZKLogService


+ (void)uploadLogInfoWithUser:(NSInteger)userId DevId:(NSString *)devid DevMac:(NSString *)devMac OpenType:(NSInteger)type success:(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVID:devid,DEVMAC:devMac,@"unlock_type":@(type),@"user_id":@(userId)};
    NSString *url = [HDZKUserService gainUrlWithModule:LOG method:@"upload-log"];
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

+ (void)getLogInfoWithBindId:(NSInteger)bindId success:(CoreSuccess )success failure:(CoreFailure)failure{

    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),DEVBINDID:@(bindId)};
    NSString *url = [HDZKUserService gainUrlWithModule:LOG method:@"get-log"];
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

+ (void)feedbackWithContent:(NSString *)content Contact:(NSString *)contact success :(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),@"contact":contact,@"content":content};
    NSString *url = [HDZKUserService gainUrlWithModule:LOG method:@"send-report"];
    [YZNetManager networkPostRequestWithParameter:param url:url success:^(id responseObject) {
        
        NSInteger code = [responseObject[CODE] integerValue];
        
        if (code == 201) {
            DLog(@"请求成功..")
            success();
        }else{
            failure(responseObject[MSG]);
        }
        
    } failure:^(YZNetError *error) {
        
        failure(error.description);
    }];
    
}

+ (void)uploadLogList:(NSArray *)list success:(CoreEmptyCallBack)success failure:(CoreFailure)failure{
    
    NSString *logs = [list yy_modelToJSONString];
    DLog(@"上传日志数组为..%@",list);
    
    NSDictionary *param = @{OPENID:YZUserModelInstance.openid,SCODE:YZ_UDGetObj(SCODE),@"list":logs};
    NSString *url = [HDZKUserService gainUrlWithModule:LOG method:@"upload-log-more"];
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

@end
