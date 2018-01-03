//
//  HDZKLockSetViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/20.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLockSetViewController.h"
#import "YZBLNickNameViewController.h"

#import "LBXAlertAction.h"

@interface HDZKLockSetViewController ()

@property (nonatomic , strong) BLSettingItem *item3;

@end

@implementation HDZKLockSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"锁设置", nil);
    
    BLSettingItem *item1 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"同步时间", nil) type:BLSettingItemTypeNone];
    item1.detailText = @"2017.12.18";
    BLSettingItem *item2 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"固件版本号", nil) type:BLSettingItemTypeNone];
    item2.detailText = @"4.16.3.3";
  
    __weak HDZKLockSetViewController *weakSelf = self;
    
    _item3 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"锁名称", nil) type:BLSettingItemTypeArrow];
    _item3.operation = ^{
        DLog(@"修改锁名称..");
        YZBLNickNameViewController *nameVC = [[YZBLNickNameViewController alloc] init];
        nameVC.gainNickName = ^(NSString *nick_name) {
            weakSelf.item3.detailText = nick_name;
            [weakSelf.tableView reloadData];
        };
        [weakSelf.navigationController pushViewController:nameVC animated:YES];
    };
    
    BLSettingItem *item4 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"关闭蓝牙广播", nil) type:BLSettingItemTypeArrow];
    item4.operation = ^{
        DLog(@"关闭蓝牙广播..");
    };
    
    
    BLSettingItem *item5 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"解绑设备", nil) type:BLSettingItemTypeArrow];
    item5.operation = ^{
        DLog(@"解绑设备..");
        
        [LBXAlertAction showAlertWithTitle:NSLocalizedString(@"提示", nil) msg:NSLocalizedString(@"这将解除设备和你的绑定关系,确定解绑吗？", nil) buttonsStatement:@[NSLocalizedString(@"取消", nil),NSLocalizedString(@"确定", nil)] chooseBlock:^(NSInteger buttonIdx) {
    
            DLog(@"点击...%ld",buttonIdx);
            
        }];
        
    };
    BLSettingGroup *group1 = [[BLSettingGroup alloc] init];
    group1.items = @[item1,item2,_item3,item4,item5];
    group1.header = NSLocalizedString(@"通用", nil);
    [self.allGroups addObject:group1];
    
    
    BLSettingItem *item6 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"打开Wi-Fi", nil) type:BLSettingItemTypeSwitch];
    item6.switchBlock = ^(BOOL on) {
        
    };
    
    BLSettingItem *item7 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"转让管理员", nil) type:BLSettingItemTypeArrow];
    item7.operation = ^{
        
        [LBXAlertAction showAlertWithTitle:NSLocalizedString(@"提示", nil) msg:NSLocalizedString(@"转让管理员后,若无新管理员授权您将不能再使用锁,确定转让吗?", nil) buttonsStatement:@[NSLocalizedString(@"取消", nil),NSLocalizedString(@"确定", nil)] chooseBlock:^(NSInteger buttonIdx) {
            
            DLog(@"点击...%ld",buttonIdx);
            
            
        }];
        
    };
    
    BLSettingItem *item8 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"恢复出厂设置", nil) type:BLSettingItemTypeArrow];
    item8.operation = ^{
        
        [LBXAlertAction showAlertWithTitle:NSLocalizedString(@"提示", nil) msg:NSLocalizedString(@"注意!这将删除所有数据并还原所有设置,确定恢复设备出厂设置么?", nil) buttonsStatement:@[NSLocalizedString(@"取消", nil),NSLocalizedString(@"确定", nil)] chooseBlock:^(NSInteger buttonIdx) {
            
            DLog(@"点击...%ld",buttonIdx);
            
            
        }];
    };
    
    BLSettingGroup *group2 = [[BLSettingGroup alloc] init];
    group2.items = @[item6,item7,item8];
    group2.header = NSLocalizedString(@"管理员", nil);
    [self.allGroups addObject:group2];
    
    self.tableView.sectionHeaderHeight = 35.0f;
    self.tableView.sectionFooterHeight = 0.0001f;
}


@end
