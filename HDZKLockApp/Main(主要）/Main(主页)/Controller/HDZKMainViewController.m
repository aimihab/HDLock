//
//  ViewController.m
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//

#import "HDZKMainViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

#import "HDZKNearbyLockViewController.h"
#import "HDZKLockSetViewController.h"

#import "HDZKLockAuthorKeysViewController.h"
#import "HDZKLockAuthorUsersViewController.h"
#import "HDZKLockOpenRecordsViewController.h"

#import "HDZKLockStateInfoCell.h"
#import "HDZKLockInfoViewCell.h"

#import "YZAuthID.h"
#import "HDZKUserData.h"


@interface HDZKMainViewController (){
    
    BabyBluetooth *baby;
    
}

@end

@implementation HDZKMainViewController

#pragma mark - getters and setters



#pragma mark - life cycle
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"currency_top_icon_my_white"] style:UIBarButtonItemStylePlain target:self action:@selector(myEvent:)];
   
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"currency_top_icon_set_white"] style:UIBarButtonItemStylePlain target:self action:@selector(lockSetEvent:)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"currency_top_icon_add_white"] style:UIBarButtonItemStylePlain target:self action:@selector(addEvent:)];
 
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
   
    baby = [BabyBluetooth shareBabyBluetooth]; //初始化BabyBluetooth 蓝牙库
    [self babyBleDelegate];//设置蓝牙委托

}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self configLockStateInfoView];//配置锁相关状态数据显示
    [self configInfoView];
}


#pragma mark - setUI

- (void)configLockStateInfoView{
    
   HDZKLockStateInfoCell *stateInfoView = [[[NSBundle mainBundle] loadNibNamed:@"HDZKLockStateInfoCell" owner:self options:nil] lastObject];
    stateInfoView.frame = CGRectMake(10, 64, kScreenW-20, 80);
    [self.view addSubview:stateInfoView];
    
    YZWeakSelf(weakStateInfoView, stateInfoView);
    stateInfoView.stateButtonBlock = ^(id result) {
        
        switch ([result integerValue]) {
            case 0://提示
            {
                
                
            }
                break;
            case 1://电量
            {
                
            }
                break;
            case 2://蓝牙
            {
                [weakStateInfoView begainConnactBle];//
                
            }
                break;
            case 3://网络
            {
                
                
            }
            default:
                break;
        }
        
    };
    
    
}


- (void)configInfoView{
    
    HDZKLockInfoViewCell *infoView = [[[NSBundle mainBundle] loadNibNamed:@"HDZKLockInfoViewCell" owner:self options:nil] lastObject];
    infoView.frame = CGRectMake(0, self.view.height-59, kScreenW, 60);
    [self.view addSubview:infoView];
    infoView.infoViewEventBlock = ^(id result) {
        
        switch ([result integerValue]) {
            case 0://授权钥匙
            {
                HDZKLockAuthorKeysViewController *keysVC = [[HDZKLockAuthorKeysViewController alloc] init];
                [self.navigationController pushViewController:keysVC animated:YES];
                
            }
                break;
            case 1://授权用户
            {
                HDZKLockAuthorUsersViewController *usersVC = [[HDZKLockAuthorUsersViewController alloc] init];
                [self.navigationController pushViewController:usersVC animated:YES];
                
            }
                break;
            case 2://开锁记录
            {
                HDZKLockOpenRecordsViewController *recordsVC = [[HDZKLockOpenRecordsViewController alloc] init];
                [self.navigationController pushViewController:recordsVC animated:YES];
                
            }
                break;
            default:
                break;
        }
    };
}

/*
- (BOOL)prefersStatusBarHidden{
    return YES;
}
*/

#pragma mark - BabyBluetoothDelegate

- (void)babyBleDelegate{
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
    }];
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备
        //if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //    return YES;
        //}
        //return NO;
        //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 1
        if (peripheralName.length >1) {
            return YES;
        }
        return NO;
    }];
    
    
}


#pragma mark - event response

- (void)myEvent:(UIBarButtonItem *)sender{
    
     [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)addEvent:(UIBarButtonItem *)sender{
    
    DLog(@"扫描搜索附近锁设备...");
    HDZKNearbyLockViewController *scanLockListVC = [[HDZKNearbyLockViewController alloc] init];
    [self.navigationController pushViewController:scanLockListVC animated:YES];
    
}

- (void)lockSetEvent:(UIBarButtonItem *)sender{
    DLog(@"锁设置页面...");
    HDZKLockSetViewController *lockSetVC = [[HDZKLockSetViewController alloc] init];
    [self.navigationController pushViewController:lockSetVC animated:YES];
    
}

- (void)openLockEvent:(id)sender{
    
    if ([HDZKUserData haveBindorAuthoredLock]) {//有绑定的锁设备
    }
    
    if (HDZKUserDataInstance.currentLockModel) {//当前绑定锁设备有数据
        
        //蓝牙直接连接..
        
        
    }
    
    YZAuthID *authID = [[YZAuthID alloc] init];
    [authID yz_showAuthIDWithDescribe:nil BlockState:^(YZAuthIDState state, NSError *error) {
        
        if (state == YZAuthIDStateNotSupport) { //不支持TouchID/FaceID
            NSLog(@"对不起，当前设备不支持指纹/面部ID");
        } else if(state == YZAuthIDStateFail) { //认证失败
            NSLog(@"指纹/面部ID不正确，认证失败");
        } else if(state == YZAuthIDStateTouchIDLockout) {   //多次错误，已被锁定
            NSLog(@"多次错误，指纹/面部ID已被锁定，请到手机解锁界面输入密码");
        } else if (state == YZAuthIDStateSuccess) { //TouchID/FaceID验证成功
            NSLog(@"认证成功！");
        }
        
    }];
    
}

#pragma mark - private methods

//数据请求



@end
