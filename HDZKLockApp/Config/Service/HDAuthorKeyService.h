//
//  HDLockService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZKAuthorKeyModel;
@interface HDAuthorKeyService : NSObject


/**
 给钥匙授权

 @param model 钥匙数据模型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)authorizeKeyWithModel:(HDZKAuthorKeyModel *)model success:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 更改钥匙授权名称

 @param model 钥匙数据模型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)modifyAuthorizeKeyNameWithModel:(HDZKAuthorKeyModel *)model success:(CoreSuccess)success failure:(CoreFailure)failure;


/**
 获取授权的钥匙列表信息

 @param success 成功回调
 */
+ (void)gainUserAuthorizedKeysSuccess:(CoreSuccess)success failure:(CoreFailure)failure;




/**
 钥匙解除授权

 @param key_id 钥匙ID
 */
+ (void)unbindKeyWithKeyId:(NSString *)key_id Success:(CoreEmptyCallBack)success;



/**
 重置钥匙

 @param success 成功回调
 */
+ (void)resetKeySuccess:(CoreEmptyCallBack)success;

@end
