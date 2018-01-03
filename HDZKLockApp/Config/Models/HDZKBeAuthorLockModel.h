//
//  HDZKBeAuthorLockModel.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/27.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LQCoding.h"

@interface HDZKBeAuthorLockModel : NSObject

/**
 被授权锁ID
 */
@property (nonatomic , assign) NSInteger dev_id;

/**
 被授权锁Mac地址
 */
@property (nonatomic , copy) NSString *dev_mac;

/**
 被授权类型（1.永久 2.临时）
 */
@property (nonatomic , assign) NSInteger bind_type;

/**
 被授权锁名称
 */
@property (nonatomic , copy) NSString *dev_name;

/**
 被授权的时间戳
 */
@property (nonatomic ,assign) NSInteger authorized_time;

/**
 授权截止到期时间戳
 */
@property (nonatomic , assign) NSInteger end_time;

/**
 该条授权记录ID
 */
@property (nonatomic , assign) NSInteger  id;


@end
