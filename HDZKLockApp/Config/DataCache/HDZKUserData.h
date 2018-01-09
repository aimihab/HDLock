//
//  HDZKUserData.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HDZKUserDataInstance [HDZKUserData sharedInstance]

@class HDZKLockModel;
@class HDZKBeAuthorLockModel;
@class HDZKLogModel;

@interface HDZKUserData : NSObject

/**
 用户绑定的锁列表（用户为管理员）
 */
@property (nonatomic , strong)NSArray *bandLockList;

/**
 用户被授权的锁列表
 */
@property (nonatomic , strong)NSArray *authoredLockList;


/**
 用户开锁上传日志列表
 */
@property (nonatomic , strong) NSMutableArray *uploadLoglist;


/**
 当前最近蓝牙连接使用的锁
 */
@property (nonatomic , strong) HDZKLockModel *currentLockModel;


SingletonH


/**
 更新用户绑定锁列表数据

 @param list 新数据
 */
- (void)updateBandLockListCacheWith:(NSArray *)list;

/**
 更新用户被授权的锁列表数据
 
 @param list 新数据
 */
- (void)updateAuthoredLockListCacheWith:(NSArray <HDZKBeAuthorLockModel*>*)list;


/**
 更新用户开锁日志列表数据

 @param list 新数据
 */
- (void)updateLogListCacheWith:(HDZKLogModel *)model;

/**
 获取所有能支持开锁的锁设备名称

 @return 名称数组
 */
- (NSArray *)lockPeripheralNames;


/**
 是否有绑定的锁，或被授权的锁

 @return 是／否
 */
+ (BOOL)haveBindorAuthoredLock;



@end



