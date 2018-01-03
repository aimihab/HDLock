//
//  HDZKLockModel.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LQCoding.h"
#import <YYModel.h>

@interface HDZKLockModel : NSObject

/**
 锁ID
 */
@property (nonatomic , copy) NSString *dev_id;

/**
 锁Mac地址
 */
@property (nonatomic , copy) NSString *dev_mac;

/**
 锁类型
 */
@property (nonatomic , copy) NSString *dev_model;

/**
 锁名称
 */
@property (nonatomic , copy) NSString *dev_name;


/**
 绑定的时间戳
 */
@property (nonatomic ,assign) NSInteger bind_at;


/**
 该锁设备的绑定编号
 */
@property (nonatomic , assign) NSInteger  id;


/**
 开锁密码（通信口令、随机5位整型数）
 */
@property (nonatomic ,assign) NSInteger password;


-(instancetype)initWithDevId:(NSString *)devid
                       devMac:(NSString *)mac
                       devType:(NSString *)type
                       devName:(NSString *)name
                       passWord:(NSInteger )password;




@end
