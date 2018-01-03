//
//  HDZKLogService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HDZKLogModel;
@interface HDZKLogService : NSObject



/**
 上传日志（可废弃）

 @param model 日志数据模型
 @param success 成功回调
 */
+ (void)uploadLogInfoWithUser:(NSInteger)userId DevId:(NSString *)devid DevMac:(NSString *)devMac OpenType:(NSInteger)type success:(CoreEmptyCallBack)success failure:(CoreFailure)failure;



/**
 获取锁开锁日志记录

 @param success 成功回调
 @param failure 失败回调
 */
+ (void)getLogInfoWithBindId:(NSInteger)bindId success:(CoreSuccess )success failure:(CoreFailure)failure;




/**
 提交反馈

 @param content 内容
 @param contact 联系人
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)feedbackWithContent:(NSString *)content Contact:(NSString *)contact success :(CoreEmptyCallBack)success failure:(CoreFailure)failure;




/**
 批量上传日志

 @param list 日志数组
 */
+ (void)uploadLogList:(NSArray *)list success:(CoreEmptyCallBack)success failure:(CoreFailure)failure;



@end
