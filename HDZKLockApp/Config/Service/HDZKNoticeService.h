//
//  HDZKNoticeService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/18.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HDZKNoticeServiceInstance [HDZKNoticeService sharedInstance]

@interface HDZKNoticeService : NSObject


/**
 接收开锁消息通知
 */
@property (nonatomic ,assign) BOOL isReciveNotiOpenlock;

/**
 接收撬锁消息通知
 */
@property (nonatomic ,assign) BOOL isReciveNotiPicklock;


/**
 接收低电提醒消息通知
 */
@property (nonatomic ,assign) BOOL isReciveNotiLowPower;


/**
 震动
 */
@property (nonatomic ,assign) BOOL  isRemindVibrate;


/**
 声音
 */
@property (nonatomic ,assign) BOOL  isRemindSound;


SingletonH


@end
