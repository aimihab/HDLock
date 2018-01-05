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
#include "FingerLockApi.h"

#define BLE_SEND_MAX_LEN 17

@implementation HDZKBleService


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
        // 预加 最大包长度，如果依然小于总数据长度，可以取最大包数据大小
        if ((i + BLE_SEND_MAX_LEN) < [msgData length]) {
            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, BLE_SEND_MAX_LEN];
            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
            NSLog(@"%@",subData);
            [peripheral writeValue:subData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
            
            //根据接收模块的处理能力做相应延时
            usleep(20 * 1000);
        }else {
            NSString *rangeStr = [NSString stringWithFormat:@"%i,%i", i, (int)([msgData length] - i)];
            NSData *subData = [msgData subdataWithRange:NSRangeFromString(rangeStr)];
            [peripheral writeValue:subData forCharacteristic:character type:CBCharacteristicWriteWithResponse];
            usleep(20 * 1000);
        }
    }
}


- (NSData *)configureBleSendDataWithType:(BleCmdType)type{
    
    FingerLockApi *cmmApi = new FingerLockApi();
    
    const char* ch_uid = [YZUserModelInstance.u_id UTF8String];
    int chInt_uid = atoi(ch_uid);
    
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
            
            //ocString = [NSString stringWithFormat:<#(nonnull NSString *), ...#>]
        }
            break;
        case BleCmdTypeQueryVersion:
        {
            
            
        }
            break;
        case BleCmdTypeQueryPower:
        {
            
            
        }
            break;
        case BleCmdTypeQueryTime:
        {
            
            
        }
            break;
        case BleCmdTypeReuestSKey:
        {
            
            
        }
            break;
        case BleCmdTypeQueryLockState:
        {
            
            
        }
            break;
        case BleCmdTypeOpenLock:
        {
            
            
        }
            break;
        case BleCmdTypeAlertAdmin:
        {
            
            
        }
            break;
        case BleCmdTypeAddUser:
        {
            
            
        }
            break;
        case BleCmdTypeDeleteUser:
        {
            
            
        }
            break;
        case BleCmdTypeAddTempUser:
        {
            
            
        }
            break;
        case BleCmdTypeEnterWifiSetMode:
        {
            
            
        }
            break;
        case BleCmdTypeExitWifiSetMode:
        {
            
            
        }
            break;
        case BleCmdTypeSetRemoteServerMsg:
        {
            
            
        }
            break;
        case BleCmdTypeSetLockCheckCode:
        {
            
            
        }
            break;
        case BleCmdTypeSendRandNumberCmd:
        {
            
            
        }
            break;
        case BleCmdTypeSendCheckCode:
        {
            
            
        }
            break;
        case BleCmdTypeSetWifiSSID:
        {
            
            
        }
            break;
        case BleCmdTypeSetWifiPwd:
        {
            
            
        }
            break;
        case BleCmdTypeDisConnected:
        {
            
            
        }
            break;
        case BleCmdTypeCloseBlueBroacast:
        {
            
            
        }
            break;
        case BleCmdTypeChangeLockName:
        {
            
            
        }
            break;
        default:
            break;
    }
    
    delete cmmApi;
    
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

@end
