//
//  HDZKMessageNotiViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/16.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKMessageNotiViewController.h"
#import "HDZKNoticeService.h"

@interface HDZKMessageNotiViewController ()

@end

@implementation HDZKMessageNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"新消息通知", nil);
    
    BLSettingItem *item1  = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"接收开锁消息通知", nil) type:BLSettingItemTypeSwitch];
    item1.isSwitchOn = HDZKNoticeServiceInstance.isReciveNotiOpenlock;
    item1.switchBlock = ^(BOOL on) {
        HDZKNoticeServiceInstance.isReciveNotiOpenlock = on;
    };
    
    BLSettingItem *item2  = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"接收撬锁警示通知", nil) type:BLSettingItemTypeSwitch];
    item2.isSwitchOn = HDZKNoticeServiceInstance.isReciveNotiPicklock;
    item2.switchBlock = ^(BOOL on) {
        HDZKNoticeServiceInstance.isReciveNotiPicklock = on;
    };
    
    BLSettingItem *item3  = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"接收低电提醒通知", nil) type:BLSettingItemTypeSwitch];
    item3.isSwitchOn = HDZKNoticeServiceInstance.isReciveNotiLowPower;
    item3.switchBlock = ^(BOOL on) {
        HDZKNoticeServiceInstance.isReciveNotiLowPower = on;
    };
    BLSettingGroup *group1 = [[BLSettingGroup alloc] init];
    group1.items = @[item1,item2,item3];
    [self.allGroups addObject:group1];
    
    BLSettingItem *item4  = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"声音", nil) type:BLSettingItemTypeSwitch];
    item4.isSwitchOn = HDZKNoticeServiceInstance.isRemindSound;
    item4.switchBlock = ^(BOOL on) {
        HDZKNoticeServiceInstance.isRemindSound  = on;
    };
    
    BLSettingItem *item5  = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"震动", nil) type:BLSettingItemTypeSwitch];
    item5.isSwitchOn = HDZKNoticeServiceInstance.isRemindVibrate;
    item5.switchBlock = ^(BOOL on) {
        HDZKNoticeServiceInstance.isRemindVibrate = on;
    };
    BLSettingGroup *group2 = [[BLSettingGroup alloc] init];
    group2.items = @[item4,item5];
    [self.allGroups addObject:group2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
