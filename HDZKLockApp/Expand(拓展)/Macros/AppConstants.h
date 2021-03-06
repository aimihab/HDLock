//
//  AppConstants.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/28.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#ifndef AppConstants_h
#define AppConstants_h

#pragma mark --------几种常用block回调-----------

typedef void(^CoreEmptyCallBack)();
typedef void(^CoreSuccess)(id result);
typedef void(^CoreFailure)(id reason);
typedef void(^CoreSuccessTwoObj)(id obj1,id obj2);


#pragma mark ---------接口模块类型定义-----------

static NSString  * const BIND = @"bind";
static NSString  * const RELATIVES = @"relatives";
static NSString  * const KEY = @"key";
static NSString  * const LOG = @"log";
static NSString  * const REPORT = @"report";
static NSString  * const UNLOCK = @"unlock";


#pragma mark --------接口字段常量定义-------------

static NSString * const DEVID = @"dev_id";
static NSString * const DEVMAC = @"dev_mac";
static NSString * const DEVMODEL = @"dev_model";
static NSString * const DEVNAME = @"dev_name";
static NSString * const CHECKCODE = @"password";

static NSString * const AUTHORUSERID = @"target_openid";
static NSString * const AUTHORUSERNAME = @"target_name";
static NSString * const AUTHORTYPE = @"bind_type";
static NSString * const DEVBINDID = @"bind_id";
static NSString * const ENDTIME = @"end_time";
static NSString * const ISSYNC = @"is_sync";

static NSString * const AUTHORIZEDID = @"authorized_id";
static NSString * const AUTHORIDS = @"ids";

static NSString * const TRANSFERID = @"target_id";
static NSString * const TARGETUSERID = @"target_id";

#pragma mark --------蓝牙服务特征字段常量定义-------------

static NSString* ClientConfigCharacteristic = @"00002902-0000-1000-8000-00805f9b34fb";
static NSString* BleShieldService = @"00001000-0000-1000-8000-00805f9b34fb";
static NSString* BraceletWriteCharacteristic = @"00001001-0000-1000-8000-00805f9b34fb";//写
static NSString* BraceletReadCharacteristic = @"00001002-0000-1000-8000-00805f9b34fb";//读
static NSString* BraceletREGWriteNameCharacteristic = @"00001003-0000-1000-8000-00805f9b34fb";
static NSString* BraceletREGAddressCharacteristic = @"00001005-0000-1000-8000-00805f9b34fb";




#endif /* AppConstants_h */
