//
//  HDZKNoticeService.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/18.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKNoticeService.h"
#import "YZUserModel.h"


@implementation HDZKNoticeService

SingletonM


-(instancetype)init
{
    if (self = [super init]) {
        
        NSString *key1 = [NSString stringWithFormat:@"%@_openLock",YZUserModelInstance.u_id];
        _isReciveNotiOpenlock = YZ_UDGetObj(key1) ? [YZ_UDGetObj(key1) integerValue] : YES;
        
        NSString *key2 = [NSString stringWithFormat:@"%@_pickLock",YZUserModelInstance.u_id];
        _isReciveNotiPicklock = YZ_UDGetObj(key2) ? [YZ_UDGetObj(key2) integerValue] : YES;
        
        NSString *key3 = [NSString stringWithFormat:@"%@_lowPower",YZUserModelInstance.u_id];
        _isReciveNotiLowPower = YZ_UDGetObj(key3) ? [YZ_UDGetObj(key3) integerValue] : YES;
        
        NSString *key4 = [NSString stringWithFormat:@"%@_remindSound",YZUserModelInstance.u_id];
        _isRemindSound = YZ_UDGetObj(key4) ? [YZ_UDGetObj(key4) integerValue] : YES;
        
        NSString *key5 = [NSString stringWithFormat:@"%@_remindVibrate",YZUserModelInstance.u_id];
        _isRemindVibrate =  YZ_UDGetObj(key5) ? [YZ_UDGetObj(key5) integerValue] : YES;
    }
    return self;
}


- (void)setIsReciveNotiOpenlock:(BOOL)isReciveNotiOpenlock{
    
    _isReciveNotiOpenlock = isReciveNotiOpenlock;
    NSString *key = [NSString stringWithFormat:@"%@_openLock",YZUserModelInstance.u_id];
    if (isReciveNotiOpenlock) {
        YZ_UDSetObj(@(1), key);
    }else{
        YZ_UDSetObj(@(0), key);
    }
}

- (void)setIsReciveNotiPicklock:(BOOL)isReciveNotiPicklock{
    _isReciveNotiPicklock = isReciveNotiPicklock;
    
    NSString *key = [NSString stringWithFormat:@"%@_pickLock",YZUserModelInstance.u_id];
    if (isReciveNotiPicklock) {
         YZ_UDSetObj(@(1), key);
    }else{
        YZ_UDSetObj(@(0), key);
    }
    
}

- (void)setIsReciveNotiLowPower:(BOOL)isReciveNotiLowPower{
    
    _isReciveNotiLowPower = isReciveNotiLowPower;
    
    NSString *key = [NSString stringWithFormat:@"%@_lowPower",YZUserModelInstance.u_id];
    if (isReciveNotiLowPower) {
        
         YZ_UDSetObj(@(1), key);
    }else{
         YZ_UDSetObj(@(0), key);
        
    }
    
}

- (void)setIsRemindSound:(BOOL)isRemindSound{
    
    _isRemindSound = isRemindSound;
    
    NSString *key = [NSString stringWithFormat:@"%@_remindSound",YZUserModelInstance.u_id];
    if (isRemindSound) {
         YZ_UDSetObj(@(1), key);
    }else{
        
         YZ_UDSetObj(@(0), key);
    }
}


- (void)setIsRemindVibrate:(BOOL)isRemindVibrate{
    
    _isRemindVibrate = isRemindVibrate;
    
    NSString *key = [NSString stringWithFormat:@"%@_remindVibrate",YZUserModelInstance.u_id];
    if (isRemindVibrate) {
        YZ_UDSetObj(@(1), key);
    }else{
        
        YZ_UDSetObj(@(0), key);
    }
}



/*
- (BOOL)isReciveNotiOpenlock{

    NSString *key = [NSString stringWithFormat:@"%@_openLock",YZUserModelInstance.u_id];
    if (YZ_UDGetObj(key)) {
        BOOL value = [YZ_UDGetObj(key) boolValue];
        return value;
    }

    return YES;
}

- (BOOL)isReciveNotiPicklock{
    
    NSString *key = [NSString stringWithFormat:@"%@_pickLock",YZUserModelInstance.u_id];
    if (YZ_UDGetObj(key)) {
        BOOL value = [YZ_UDGetObj(key) boolValue];
        return value;
    }
    
    return YES;
    
}

- (BOOL)isReciveNotiLowPower{
    
    NSString *key = [NSString stringWithFormat:@"%@_lowPower",YZUserModelInstance.u_id];
    if (YZ_UDGetObj(key)) {
        BOOL value = [YZ_UDGetObj(key) boolValue];
        return value;
    }
    
    return YES;
}

- (BOOL)isRemindSound{
    
    NSString *key = [NSString stringWithFormat:@"%@_remindSound",YZUserModelInstance.u_id];
    if (YZ_UDGetObj(key)) {
        BOOL value = [YZ_UDGetObj(key) boolValue];
        return value;
    }
    
    return YES;
}


- (BOOL)isRemindVibrate{
    
    NSString *key = [NSString stringWithFormat:@"%@_remindVibrate",YZUserModelInstance.u_id];
    if (YZ_UDGetObj(key)) {
        BOOL value = [YZ_UDGetObj(key) boolValue];
        return value;
    }
    return YES;
}

*/


@end
