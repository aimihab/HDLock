//
//  HDZKLockModel.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLockModel.h"

@implementation HDZKLockModel

-(instancetype)initWithDevId:(NSString *)devid devMac:(NSString *)mac devType:(NSString *)type devName:(NSString *)name passWord:(NSInteger )password{
    
    if (self =  [super init]) {
        
        self.dev_id = devid;
        self.dev_mac = mac;
        self.dev_model = type;
        self.dev_name = name;
        self.password = [self getRandomNumber:10 to:100];
        
    }
    return self;
}


/**
 获取一个随机数

 @param from 10
 @param to 100
 @return 随机数值
 */
-(int)getRandomNumber:(int)from to:(int)to{
    
    return (int)(from + (arc4random() % (to - from + 1)));
}


@end
