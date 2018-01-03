//
//  HDUserLockService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZKLockModel;
@class HDZKAuthorUserModel;
@interface HDUserLockService : NSObject



/**
 绑定锁设备

 @param devid 设备ID
 @param mac 设备Mac地址
 @param model 设备型号
 @param name 设备名称
 @param code 设备与服务器通信校验码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)bindLockWithDevID:(NSString *)devid DevMac:(NSString *)mac DevModel:(NSString *)model DevName:(NSString *)name CheckCode:(NSString *)code Success:(CoreSuccess)success Failure:(CoreFailure)failure;



/**
 给其他用户授权

 @param uid 用户ID
 @param name 授权用户名称
 @param type 授权类型（1.永久 2.临时）
 @param bindId 锁绑定ID
 @param endTime 授权有效期
 @param is_sync 是否同步（1.是 2.否）
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)authoriseUserWithUid:(NSInteger)uid userName:(NSString *)name authorType:(NSInteger)type DevBindID:(NSString *)bindId endTime:(NSString *)endTime isSync:(NSInteger)is_sync success:(CoreSuccess)success failure:(CoreFailure)failure;

/**
 获取用户绑定的锁列表
 */
+ (void)gainBindLockListSuccess:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 获取锁的授权用户列表

 @param bind_id 锁ID
 */
+ (void)gainAuthoriseUsersWithDevid:(NSString *)bind_id success:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 修改某个（锁）授权用户信息

 @param authorizedModel 授权模型
 */
+ (void)modifyDevAuthoriseUserInfoWithAuthoriseModel:(HDZKAuthorUserModel *)authorizedModel success:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 取消某个（锁）授权用户

 @param authorized_id 授权记录的ID
 */
+ (void)cancelDevAuthorisedWithID:(NSString *)authorized_id success:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 修改绑定锁的名称

 @param model 锁模型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)modfiyDevLockNameWithModel:(HDZKLockModel *)model success:(CoreSuccess)success failure:(CoreFailure)failure;



/**
 获取用户被授权的锁列表

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)gainUserbeAuthorisedDevlockListSuccess:(CoreSuccess)success failure:(CoreFailure)failure;


/**
 解绑锁

 @param bind_id 绑定ID
 @param success 成功回调
 */
+ (void)unbindDevlockWithBindID:(NSString *)bind_id success:(CoreEmptyCallBack)success failure:(CoreFailure)failure;


/**
 同步锁上的授权ID到服务器

 @param success 成功回调
 */
+ (void)syncAuthorisedIDs:(NSString *)ids toServerSuccess:(CoreEmptyCallBack)success failure:(CoreFailure)failure;



/**
 转让锁管理员权限给某个授权用户

 @param uid 转让的用户ID
 @param lockid 锁ID
 @param success 成功回调
 */
+ (void)assignmentAdministratorToUser:(NSString *)uid WithBindLock:(NSString *)lockid success:(CoreEmptyCallBack)success failure:(CoreFailure)failure;



/**
 给其他用户发送通知

 @param targetId 要通知的用户ID
 @param type 5.授权确认 6.授权用户回应授权状态
 @param imei 手机IMEI
 @param lock_name 锁名称
 @param authType 授权类型
 @param success 成功回调
 */
+ (void)sendNoticeToUser:(NSString *)targetId Type:(NSInteger)type PhoneIMEI:(NSString *)imei LockName:(NSString *)lock_name authType:(NSInteger)authType Success:(CoreEmptyCallBack)success Failure:(CoreFailure)failure;




/**
 远程开锁

 @param bind_id 绑定锁ID
 @param authorized_id 授权ID
 @param type 用户类型（1.管理员 2.授权用户）
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)requestRemoteServertoUnlockWithBindId:(NSInteger)bind_id AuthotizedId:(NSInteger)authorized_id Type:(NSInteger)type Success:(CoreEmptyCallBack)success Failure:(CoreFailure)failure;

@end
