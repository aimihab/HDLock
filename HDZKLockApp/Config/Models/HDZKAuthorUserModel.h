//
//  HDZKAuthorUserModel.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface HDZKAuthorUserModel : NSObject

/**
 授权用户u_id
 */
@property (nonatomic , assign) NSInteger u_id;

/**
 授权用户名称
 */
@property (nonatomic ,copy) NSString *target_name;

/**
 授权用户头像地址
 */
@property (nonatomic , copy) NSString *u_head_url;

/**
 授权方式（永久授权、临时授权）
 */
@property (nonatomic , assign) NSInteger bind_type;

/**
 授权时间
 */
@property (nonatomic , assign) NSInteger authorized_time;

/**
 授权截止到期时间
 */
@property (nonatomic , copy) NSString *end_time;


/**
 绑定的锁的ID
 */
@property (nonatomic , copy) NSString *bind_id;

/**
 是否已经同步
 */
@property (nonatomic , assign) NSInteger is_sync;


/**
 该条授权记录的id编号
 */
@property (nonatomic , assign) NSInteger id;




@end
