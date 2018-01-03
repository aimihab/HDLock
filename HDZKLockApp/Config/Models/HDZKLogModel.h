//
//  HDZKLogModel.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LQCoding.h"

@interface HDZKLogModel : NSObject

/**
 锁设备的ID
 */
@property (nonatomic , copy) NSString *dev_id;

/**
 锁设备在服务器的绑定ID
 */
@property (nonatomic , copy) NSString *bind_id;

/**
 用户ID
 */
@property (nonatomic , copy) NSString *user_id;


/**
 开锁的类型
 */
@property (nonatomic , assign) NSInteger unlock_type;


/**
 日志上报时间
 */
@property (nonatomic , assign) NSInteger log_time;


/**
 日志编号ID
 */
@property (nonatomic , assign) NSInteger id;


@end
