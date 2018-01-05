//
//  HDZKBleService.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/22.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BabyBluetooth.h>

typedef NS_ENUM (NSInteger,BleCmdType){
    
    BleCmdTypeCetDeviceID = 0,
    BleCmdTypeReset, //重置锁
    BleCmdTypeSetTime,//同步设置时间
    BleCmdTypeUpdate,//固件升级
    BleCmdTypeRestart,//重启锁
    BleCmdTypeOpenWifi,//打开Wi-Fi
    BleCmdTypeQueryVersion,//查询版本
    BleCmdTypeQueryPower,//查询电量
    BleCmdTypeReuestSKey,//请求密钥
    BleCmdTypeQueryTime,//查询时间
    BleCmdTypeQueryLockState,//查询锁状态
    BleCmdTypeOpenLock,//开锁
    BleCmdTypeAlertAdmin,//管理提示
    BleCmdTypeAddUser,//添加授权用户
    BleCmdTypeDeleteUser,//删除授权用户
    BleCmdTypeAddTempUser,//添加临时用户
    BleCmdTypeEnterWifiSetMode,//进入设置Wi-Fi模式
    BleCmdTypeExitWifiSetMode,//退出设置Wi-Fi模式
    BleCmdTypeSetRemoteServerMsg,
    BleCmdTypeSetLockCheckCode,//设置锁校验码
    BleCmdTypeSendRandNumberCmd,//发送随机数
    BleCmdTypeSendCheckCode,//发送校验码
    BleCmdTypeSetWifiSSID,//设置Wi-Fi名称
    BleCmdTypeSetWifiPwd,//设置Wi-Fi密码
    BleCmdTypeDisConnected,//断开连接
    BleCmdTypeCloseBlueBroacast,//关闭蓝牙广播
    BleCmdTypeChangeLockName //修改锁名称
};
    
@interface HDZKBleService : NSObject

SingletonH

@property (nonatomic , strong) CBPeripheral *currentPeripheral;


- (void)sendBleDataWithCmdType:(BleCmdType)type Peripheral:(CBPeripheral*)peripheral Characteristic:(CBCharacteristic*)character;


@end
