//
//  HDZKPsdSetViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/16.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKPsdSetViewController.h"
#import "HDZKPsdDetailViewController.h"

@interface HDZKPsdSetViewController ()

@end

@implementation HDZKPsdSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"密码与指纹", nil);
    
    BLSettingItem *item1 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"密码认证", nil) type:BLSettingItemTypeArrow];
    item1.operation = ^{//设置密码
        
        HDZKPsdDetailViewController *psdVC = [[HDZKPsdDetailViewController alloc] init];
        [self.navigationController pushViewController:psdVC animated:YES];
        
    };
    BLSettingGroup *group1 = [[BLSettingGroup alloc] init];
    group1.items = @[item1];
    [self.allGroups addObject:group1];
    
    BLSettingItem *item2 = [BLSettingItem itemWithIcon:nil title:NSLocalizedString(@"启用指纹认证", nil) type:BLSettingItemTypeSwitch];
    
    item2.switchBlock = ^(BOOL on) {
        
        if (on) {
            
        }
        
    };
    
    BLSettingGroup *group2 = [[BLSettingGroup alloc] init];
    group2.items = @[item2];
    group2.footer = NSLocalizedString(@"将手指放在Home键处，通过指纹认证快速开锁", nil);
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
