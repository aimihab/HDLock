//
//  HDZKLockData.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/27.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HDZKLockDataInstance [HDZKLockData sharedInstance]

@class HDZKAuthorUserModel;
@class HDZKLogModel;
@interface HDZKLockData : NSObject

/**
 锁与服务器直接通信的安全校验码（由APP生成4个字节随机数，第一次绑定锁的时候同步）
 */
@property (nonatomic , assign) int checkCode;

/**
 锁的授权用户列表
 */
@property (nonatomic , strong,readonly)NSArray *authorUserList;

/**
 锁的日志记录列表
 */
@property (nonatomic , strong,readonly) NSMutableArray *lockLoglist;


SingletonH




@end
