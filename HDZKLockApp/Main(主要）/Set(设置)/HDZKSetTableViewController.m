//
//  HDZKSetTableViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/14.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKSetTableViewController.h"
#import "HDZKMessageNotiViewController.h"
#import "HDZKPsdSetViewController.h"
#import "YZBLOpinionViewController.h"
#import "HDZKAboutViewController.h"

#import "BLSettingCell.h"
#import "HDZKUserService.h"
#import "LBXAlertAction.h"

@interface HDZKSetTableViewController ()


@end

@implementation HDZKSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"设置", nil);
    
    BLSettingItem *item1 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"新消息通知", nil) type:BLSettingItemTypeArrow];
    item1.operation = ^{
        HDZKMessageNotiViewController *notiVC = [[HDZKMessageNotiViewController alloc] init];
        [self.navigationController pushViewController:notiVC animated:YES];
    };
  
    BLSettingItem *item2 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"密码与指纹", nil) type:BLSettingItemTypeArrow];
    item2.operation = ^{
        HDZKPsdSetViewController *psdSetVC = [[HDZKPsdSetViewController alloc] init];
        [self.navigationController pushViewController:psdSetVC animated:YES];
    };
    /*
    BLSettingItem *item3 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"开锁模式", nil) type:BLSettingItemTypeArrow];
    item3.operation = ^{
        
    };
    */
    BLSettingGroup *group1 = [[BLSettingGroup alloc] init];
    group1.items = @[item1,item2];
    [self.allGroups addObject:group1];
    
    BLSettingItem *item4 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"帮助中心", nil) type:BLSettingItemTypeArrow];
    item4.operation = ^{
        
    };
    
    BLSettingItem *item5 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"意见反馈", nil) type:BLSettingItemTypeArrow];
    item5.operation = ^{
        YZBLOpinionViewController *opinionVC = [[YZBLOpinionViewController alloc] init];
        [self.navigationController pushViewController:opinionVC animated:YES];
    };
    
    BLSettingItem *item6 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"关于我们", nil) type:BLSettingItemTypeArrow];
    item6.operation = ^{
        HDZKAboutViewController *aboutVC = [[HDZKAboutViewController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    };
    
    BLSettingGroup *group2 = [[BLSettingGroup alloc] init];
    group2.items = @[item4,item5,item6];
    [self.allGroups addObject:group2];
    
    BLSettingItem *loginItem = [BLSettingItem itemWithIcon:nil title:nil type:BLSettingItemTypeNone];
    loginItem.operation = ^{//退出登录
        
        [LBXAlertAction showAlertWithTitle:NSLocalizedString(@"提示", nil) msg:@"是否确定退出登录？退出登录将不再收到推送消息" buttonsStatement:@[NSLocalizedString(@"取消", nil),NSLocalizedString(@"确定", nil)] chooseBlock:^(NSInteger buttonIdx) {
            
            if (buttonIdx == 1) {
                /*
                [HDZKUserService loginoutWithSuccess:^{
                    DLog(@"退出登录成功..");
                }];
                */
                 [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(0)];
            }
        }];
    };
    BLSettingGroup *group3 = [[BLSettingGroup alloc] init];
    group3.items = @[loginItem];
    [self.allGroups addObject:group3];
    
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return section == 2 ? 1 : 3;
}
*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 1.创建一个BLSettingCell
    BLSettingCell *cell = [BLSettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（BLSettingItem）
    BLSettingGroup *group = self.allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    
    
    if(indexPath.section == 2){
        
        UILabel *logoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 55)];
        [cell.contentView addSubview:logoutLabel];
        logoutLabel.text = NSLocalizedString(@"退出登录", nil);
        logoutLabel.textColor = HZWakeupColor;
        logoutLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return cell;
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




@end
