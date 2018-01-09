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
#import "HDZKBleService.h"

#import <CoreBluetooth/CoreBluetooth.h>

@interface HDZKMainViewController (){
    
    BabyBluetooth *baby;
    int cuurentPeripheralRssi;
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
    cuurentPeripheralRssi = 0;
    [self babyBleDelegate];//设置蓝牙委托
 //   baby.scanForPeripherals().begin().stop(10);//扫描10s停止
   baby.scanForPeripherals().connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().begin(); //扫描、连接
    
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
    
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            DLog(@"设备打开成功..开始扫描设备");
        }
    }];
    
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置扫描设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //搜索查找“HDAI”前缀开头的慧点锁设备
        if ([peripheralName hasPrefix:@"HDAI"] ) {
            return YES;
        }
        return NO;
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        DLog(@"搜索到了设备:%@",peripheral.name);
        if (cuurentPeripheralRssi > [RSSI intValue]) {
            cuurentPeripheralRssi = [RSSI intValue];
            
            HDZKBleServiceInstance.currentLockPeripheral = peripheral;
            /*
            if ([[HDZKUserDataInstance lockPeripheralNames] containsObject:peripheral.name]) {
                HDZKBleServiceInstance.currentLockPeripheral = peripheral;
            }
             */
        }else{
            
            
            
        }
        
        
    }];
    
    /*
     *搜索设备后连接设备：1:先设置连接的设备的filter 2进行连接
     */
    //1：设置连接的设备的过滤器
    __block BOOL isFirst = YES;
    [baby setFilterOnConnectToPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //这里的规则是：连接第一个AAA打头的设备
        if(isFirst && [peripheralName hasPrefix:@"HDAI"]){
            isFirst = NO;
            return YES;
        }
        return NO;
    }];
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        DLog(@"设备：%@--连接成功",peripheral.name);
        [MBProgressHUD showSuccessMessage:NSLocalizedString(@"%@连接成功",peripheral.name)];
        HDZKBleServiceInstance.currentLockPeripheral = peripheral;
        
    }];
    
    //设置设备连接失败的委托
    [baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        DLog(@"设备：%@--连接失败",peripheral.name);
    }];
    
    //设置设备断开连接的委托
    [baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        DLog(@"设备：%@--断开连接",peripheral.name);
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *s in peripheral.services) {
            //每个service
        }
        
    }];
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
        
    }];
    
    YZWeakSelf(weakSelf, self);
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        
        DLog(@"characteristic name:%@ value is:%@",characteristic.UUID,characteristic.value);
        
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BraceletReadCharacteristic]]) {
            //   [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            [weakSelf notifyPeripheral:peripheral Characteristic:characteristic];//监听读通道
            DLog(@"读通道");
            HDZKBleServiceInstance.lockReadChar = characteristic;
        }
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:BraceletWriteCharacteristic]]) {
            DLog(@"写通道");
            HDZKBleServiceInstance.lockWriteChar = characteristic;
        }
        
        if (HDZKBleServiceInstance.lockWriteChar != nil && HDZKBleServiceInstance.currentLockPeripheral != nil) {
            
            [weakSelf sendBleCmdEvent];
        }

    }];

    //写Characteristic成功后的block
    [baby setBlockOnDidWriteValueForCharacteristic:^(CBCharacteristic *characteristic, NSError *error) {
        DLog(@"写成功...");
    }];
    
}


-(void)sendBleCmdEvent{
    
    [HDZKBleServiceInstance sendBleDataWithCmdType:BleCmdTypeSendRandNumberCmd Peripheral:HDZKBleServiceInstance.currentLockPeripheral Characteristic:HDZKBleServiceInstance.lockWriteChar];
    [HDZKBleServiceInstance sendBleDataWithCmdType:BleCmdTypeSendCheckCode Peripheral:HDZKBleServiceInstance.currentLockPeripheral Characteristic:HDZKBleServiceInstance.lockWriteChar];
    
}


- (void)notifyPeripheral:(CBPeripheral *)peripheral Characteristic:(CBCharacteristic *)characteristic{
    
    [baby notify:peripheral characteristic:characteristic  block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        //接收到值会进入这个方法
        DLog(@"-----------new value %@",characteristics.value);
        
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
