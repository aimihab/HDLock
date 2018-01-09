//
//  HDZKBleService.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/22.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKBleService.h"
#import "YZUserModel.h"
#import "DYDeviceInfo.h"
#import "TTC_Ble_Encryption_lib.h"
#import "NSDate+Expend.h"

#include "FingerLockApi.h"
#define BLE_SEND_MAX_LEN 17

@implementation HDZKBleService

SingletonM

-(instancetype)init
{
    if (self = [super init]) {
        
        self.lockWriteChar = nil;
        self.lockReadChar = nil;
       
    }
    return self;
}



#pragma mark - public

- (void)sendBleDataWithCmdType:(BleCmdType)type Peripheral:(CBPeripheral*)peripheral Characteristic:(CBCharacteristic*)character {
    
    NSData *msgData = [self configureBleSendDataWithType:type];
    
    [self sendMsgWithSubPackage:msgData Peripheral:peripheral Characteristic:character];
}


#pragma mark - private

//分包发送蓝牙数据
-(void)sendMsgWithSubPackage:(NSData*)msgData
                  Peripheral:(CBPeripheral*)peripheral
              Characteristic:(CBCharacteristic*)character
{
    for (int i = 0; i < [msgData length]; i += BLE_SEND_MAX_LEN) {
        // 预加最大包长度，如果依然小于总数据长度，可以取最大包数据大小
        if ((i + BLE_SEND_MAX_LEN) < [msgData length]) {
            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, BLE_SEND_MAX_LEN];

            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
            DLog(@"%@",subData);
            NSString *subStr = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
            NSData *subEncryptData = [TTC_Ble_Encryption_lib encryption:subStr];//加密
            [peripheral writeValue:subEncryptData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
            
            //根据接收模块的处理能力做相应延时
            usleep(20 * 1000);
        }else {
            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, (int)([msgData length] - i)];
            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
            NSString *subStr = [[NSString alloc] initWithData:subData encoding:NSUTF8StringEncoding];
            NSData *subEncryptData = [TTC_Ble_Encryption_lib encryption:subStr];//加密
            [peripheral writeValue:subEncryptData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
            usleep(20 * 1000);
        }
    }
}


- (NSData *)configureBleSendDataWithType:(BleCmdType)type{
    
    FingerLockApi *cmmApi = new FingerLockApi();
    
 //   const char* ch_uid = [YZUserModelInstance.u_id UTF8String];
  //  int chInt_uid = atoi(ch_uid);
    int chInt_uid = [YZUserModelInstance.u_id intValue];
    
    const char *ch_imei = [[DYDeviceInfo dy_getDeviceUUID] UTF8String];
    
    NSString *ocString = @"";
    
    switch (type) {
        case BleCmdTypeCetDeviceID:
        {
            /*
            NSString *ocString = [NSString stringWithUTF8String:cmmApi->deviceIdCmd(chInt_uid, ch_imei).c_str()];
            */
            ocString = [NSString stringWithCString:cmmApi->deviceIdCmd(chInt_uid, ch_imei).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeReset:
        {
            ocString = [NSString stringWithCString:cmmApi->resetCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeSetTime:
        {
            NSString *ocTimeStr = [NSString stringWithFormat:@"%@",@"201801051841"];
            const char *now = [ocTimeStr UTF8String];
            ocString = [NSString stringWithCString:cmmApi->setTimeCmd(now).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeUpdate:
        {
            ocString = [NSString stringWithCString:cmmApi->updateCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeRestart:
        {
            
            ocString = [NSString stringWithCString:cmmApi->restartCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeOpenWifi:
        {
            
            ocString = [NSString stringWithCString:cmmApi->openWifiCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeQueryVersion:
        {
            
            ocString = [NSString stringWithCString:cmmApi->queryVersionCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeQueryPower:
        {
            
            ocString = [NSString stringWithCString:cmmApi->queryPowerCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeQueryTime:
        {
            
            ocString = [NSString stringWithCString:cmmApi->queryTimeCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeReuestSKey:
        {
            ocString = [NSString stringWithCString:cmmApi->reuestSKeyCmd().c_str() encoding:[NSString defaultCStringEncoding]];
            
        }
            break;
        case BleCmdTypeQueryLockState:
        {
            ocString = [NSString stringWithCString:cmmApi->queryLockStateCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeOpenLock:
        {
            ocString = [NSString stringWithCString:cmmApi->openLockCmd().c_str() encoding:[NSString defaultCStringEncoding]];
            
        }
            break;
        case BleCmdTypeAlertAdmin:
        {
            
            ocString = [NSString stringWithCString:cmmApi->alertAdminCmd(chInt_uid, ch_imei).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeAddUser:
        {
            
            ocString = [NSString stringWithCString:cmmApi->addUserCmd(chInt_uid, ch_imei).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeDeleteUser:
        {
            ocString = [NSString stringWithCString:cmmApi->deleteUserCmd(chInt_uid).c_str() encoding:[NSString defaultCStringEncoding]];
            
        }
            break;
        case BleCmdTypeAddTempUser:
        {
            
            const char *now = [[self ocNowtime] UTF8String];
            ocString = [NSString stringWithCString:cmmApi->addTempUserCmd(chInt_uid, now, ch_imei).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeEnterWifiSetMode:
        {
            
            ocString = [NSString stringWithCString:cmmApi->enterWifiSettingModeCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeExitWifiSetMode:
        {
            
            ocString = [NSString stringWithCString:cmmApi->exitWifiSettingModeCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeSetRemoteServerMsg:
        {
            const char *ip = [@"192.168.0.1" UTF8String];
            const char *port = [@"4068" UTF8String];
            
            ocString = [NSString stringWithCString:cmmApi->setRemoteServerMsgCmd(ip, port).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeSetLockCheckCode:
        {
            int code = 3546;
            ocString = [NSString stringWithCString:cmmApi->setLockCheckCodeCmd(code).c_str() encoding:[NSString defaultCStringEncoding]];
            
        }
            break;
        case BleCmdTypeSendRandNumberCmd:
        {
            
            ocString = [NSString stringWithCString:cmmApi->sendRandNumberCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeSendCheckCode:
        {
            
            const char *appid = [[self appIdStr] UTF8String];
            ocString = [NSString stringWithCString:cmmApi->sendCheckCodeCmd(appid).c_str() encoding:[NSString defaultCStringEncoding]];
            
        }
            break;
        case BleCmdTypeSetWifiSSID:
        {
            const char *wifiSSID = [@"shdshjkadha" UTF8String];
            ocString = [NSString stringWithCString:cmmApi->setWifiSSIDCmd(wifiSSID).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeSetWifiPwd:
        {
            const char *wifiPwd = [@"shjdashksdh" UTF8String];
            ocString = [NSString stringWithCString:cmmApi->setWifiPwdCmd(wifiPwd).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeDisConnected:
        {
            ocString = [NSString stringWithCString:cmmApi->disConnectedCmd().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeCloseBlueBroacast:
        {
            
            ocString = [NSString stringWithCString:cmmApi->closeBlueBroacast().c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        case BleCmdTypeChangeLockName:
        {
            const char *lockName = [@"haha" UTF8String];
            ocString = [NSString stringWithCString:cmmApi->changeLockName(lockName).c_str() encoding:[NSString defaultCStringEncoding]];
        }
            break;
        default:
            break;
    }
    
    delete cmmApi;
    DLog("命令字符串为..%@",ocString);
    
    NSData *msgData = [ocString dataUsingEncoding:NSUTF8StringEncoding];
    return msgData;
}



#pragma mark - other

- (int)convertToByte:(NSString*)str {
    int strlength = 0;
    char* p = (char*)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}



- (void)writeCharacteristic:(CBPeripheral*)peripheral characteristic:(CBCharacteristic*)character value:(NSData *)subData{
    
    [peripheral writeValue:subData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
}



/**
 获取当前时间

 @return 返回类似"201801081928"
 */
- (NSString *)ocNowtime{
    
    NSString *now = [NSString stringWithFormat:@"%d%d%d%d%d",[NSDate getCurrentYear],[NSDate getCurrentMonth],[NSDate getCurrentDay],[NSDate getCurrentHour],[NSDate getCurrentMin]];
    
    return now;
}


/**
 APPID指定为四个字节

 @return 返回OC字符串
 */
- (NSString *)appIdStr{
    
    NSString *appId = [BabyToy ConvertHexStringToString:@"{0xf1,0x1A,0x2A,0xfe}"];
    return appId;
}

@end
