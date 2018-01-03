//
//  HDZKNearbyLockViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/20.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKNearbyLockViewController.h"
#import "UINavigationController+LQProgress.h"

@interface HDZKNearbyLockViewController (){
    
    NSMutableArray *peripheralDataArray;
    BabyBluetooth *baby;
}

@property (nonatomic , strong) UIButton *scanButton;

@end

@implementation HDZKNearbyLockViewController

#pragma mark - getter
- (UIButton *)scanButton{
    
    if (_scanButton == nil) {
        
        _scanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _scanButton.backgroundColor = [UIColor whiteColor];
        _scanButton.frame = CGRectMake(20, self.view.height-70, kScreenW-40, 40);
        _scanButton.clipsToBounds = YES;
        _scanButton.layer.cornerRadius = _scanButton.height/2;
        _scanButton.layer.borderWidth = 1.0f;
        _scanButton.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        [_scanButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_scanButton addTarget:self action:@selector(scanAnimationEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_scanButton];
        [self.view bringSubviewToFront:_scanButton];
    }
    
    return _scanButton;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"附近的锁", nil);
    self.view.backgroundColor = HZOverallBackGroundColor;
   
    [self scanAnimationEvent];
 
    baby = [BabyBluetooth shareBabyBluetooth];
    [self babyBleDelegate];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [self.navigationController cancelLQProgress];
    
}

#pragma mark - Public

- (void)scanAnimationEvent{
    
    [self.scanButton setTitle:NSLocalizedString(@"正在努力扫描锁..", nil) forState:UIControlStateNormal];
    self.scanButton.enabled = NO;
    [self.navigationController showLQProgressWithDuration:5.0f andTintColor:HZLockMainColor];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scanButton.enabled = YES;
        [self.scanButton setTitle:NSLocalizedString(@"重新扫描", nil) forState:UIControlStateNormal];
    });
    
}



#pragma mark - 蓝牙配置和操作
- (void)babyBleDelegate{
    
    __weak typeof(self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            DLog(@"s手机蓝牙打开成功，开始扫描设备..");
        }
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        [weakSelf insertTableView:peripheral advertisementData:advertisementData RSSI:RSSI];
    }];
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
        //        if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //            return YES;
        //        }
        //        return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
}

#pragma mark -UIViewController 方法
//插入table数据
-(void)insertTableView:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSArray *peripherals = [peripheralDataArray valueForKey:@"peripheral"];
    if(![peripherals containsObject:peripheral]) {
        NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:peripherals.count inSection:0];
        [indexPaths addObject:indexPath];
        
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        [item setValue:peripheral forKey:@"peripheral"];
        [item setValue:RSSI forKey:@"RSSI"];
        [item setValue:advertisementData forKey:@"advertisementData"];
        [peripheralDataArray addObject:item];
        
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark -table委托 table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return peripheralDataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    NSDictionary *advertisementData = [item objectForKey:@"advertisementData"];
    NSNumber *RSSI = [item objectForKey:@"RSSI"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //peripheral的显示名称,优先用kCBAdvDataLocalName的定义，若没有再使用peripheral name
    NSString *peripheralName;
    if ([advertisementData objectForKey:@"kCBAdvDataLocalName"]) {
        peripheralName = [NSString stringWithFormat:@"%@",[advertisementData objectForKey:@"kCBAdvDataLocalName"]];
    }else if(!([peripheral.name isEqualToString:@""] || peripheral.name == nil)){
        peripheralName = peripheral.name;
    }else{
        peripheralName = [peripheral.identifier UUIDString];
    }
    
    cell.textLabel.text = peripheralName;
    //信号和服务
    cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI:%@",RSSI];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //停止扫描
    [baby cancelScan];
    
    /*
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeripheralViewController *vc = [[PeripheralViewController alloc] init];
    NSDictionary *item = [peripheralDataArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = [item objectForKey:@"peripheral"];
    vc.currPeripheral = peripheral;
    vc->baby = self->baby;
    [self.navigationController pushViewController:vc animated:YES];
    */
}


@end
