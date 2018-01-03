//
//  HDZKLeftSideViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/12.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLeftSideViewController.h"
#import "HDZKSetTableViewController.h"
#import "YZBLMyInfoViewController.h"
#import "HDZKOpenRecordsViewController.h"
#import "HDZKNoticeListViewController.h"
#import "HDZKMyBridalPartyViewController.h"
#import "HDZKMyKeychainViewController.h"


#import "AppDelegate.h"
#import "HDZKLeftHeadCell.h"
#import "UIViewController+MMDrawerController.h"

@interface HDZKLeftSideViewController ()

@property (nonatomic , strong) HDZKLeftHeadCell *myInfoHeadView;
@property (nonatomic , strong) UIButton *setButton;

@property (nonatomic , strong)NSArray *titleArray;
@property (nonatomic , strong)NSArray *iconImages;

@end

@implementation HDZKLeftSideViewController

#pragma mark - getter && setter

- (HDZKLeftHeadCell *)myInfoHeadView{
    
    if (_myInfoHeadView == nil){
        
        _myInfoHeadView = [[[NSBundle mainBundle] loadNibNamed:@"HDZKLeftHeadCell" owner:self options:nil] lastObject];
        [_myInfoHeadView refrshUIWithUserMoel:YZUserModelInstance];
        YZWeakSelf(weakSelf, self);
        _myInfoHeadView.tapAvatarBlock = ^{
            YZBLMyInfoViewController *myInfoVC = [[YZBLMyInfoViewController alloc] init];
             myInfoVC.userModel = YZUserModelInstance;
            YZStrongSelf(strongSelf, weakSelf);
            [strongSelf pushToViewController:myInfoVC];
        };
    }
    
    return _myInfoHeadView;
}

- (UIButton *)setButton{
    
    if(_setButton == nil){
        _setButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _setButton.frame = CGRectMake([AppDelegate leftViewWith] - 70, 30, 60, 60);
        [_setButton setImage:[UIImage imageNamed:@"User_sidebar_icon7"] forState:UIControlStateNormal];
        [_setButton addTarget:self action:@selector(mySetEvent:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _setButton;
    
}


#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"left View";
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];//分割线顶边
        [self.tableView setSeparatorColor:HZDividerTextColor];//分割线颜色
    }
    
    self.tableView.tableHeaderView = self.myInfoHeadView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 100)];
    [self.tableView.tableFooterView addSubview:self.setButton];
    
    _titleArray = @[@"开锁记录",@"消息通知",@"我的亲友团",@"我的钥匙串"];
    
}

#pragma mark - action

- (void)mySetEvent:(UIButton *)sender{
    
    DLog(@"设置...");
    HDZKSetTableViewController *setVC = [[HDZKSetTableViewController alloc] init];
    [self pushToViewController:setVC];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"User_sidebar_icon%ld",indexPath.row+1]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0://开锁记录
        {
            HDZKOpenRecordsViewController *recordsVC = [[HDZKOpenRecordsViewController alloc] init];
            [self pushToViewController:recordsVC];
            
            
        }
        break;
        case 1://消息通知
        {
            HDZKNoticeListViewController *noticeListVC = [[HDZKNoticeListViewController alloc] init];
            [self pushToViewController:noticeListVC];
            
        }
        break;
        case 2://我的亲友团
        {
            HDZKMyBridalPartyViewController *partyVC = [[HDZKMyBridalPartyViewController alloc] init];
            [self pushToViewController:partyVC];
            
        }
        break;
        case 3://我的钥匙串
        {
            HDZKMyKeychainViewController *keyChainVC = [[HDZKMyKeychainViewController alloc] init];
            [self pushToViewController:keyChainVC];
        }
        break;
        default:
        break;
    }
    
}


#pragma mark - Public

- (void)pushToViewController:(UIViewController *)viewController{
    
    HDZKBaseNavController *nav = (HDZKBaseNavController *)self.mm_drawerController.centerViewController;
    
    [nav pushViewController:viewController animated:NO];
    
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //  [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}


@end
