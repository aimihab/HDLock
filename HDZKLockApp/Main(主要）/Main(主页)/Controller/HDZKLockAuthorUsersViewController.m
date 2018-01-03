//
//  HDZKLockAuthorUsersViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/22.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLockAuthorUsersViewController.h"
#import "HDZKAddWithPhoneViewController.h"
#import "YZBLMyQrCodeViewController.h"
#import "YZBLScanViewController.h"

#import "PopoverView.h"
#import "StyleDIY.h"

@interface HDZKLockAuthorUsersViewController ()

@end

@implementation HDZKLockAuthorUsersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = NSLocalizedString(@"授权用户", nil);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"currency_top_icon_add_gray"] style:UIBarButtonItemStylePlain target:self action:@selector(addEvent:)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


#pragma mark - action

- (void)addEvent:(UIBarButtonItem *)sender{
    
    PopoverAction *action1 = [PopoverAction actionWithTitle:NSLocalizedString(@"手机号码添加", nil) handler:^(PopoverAction *action) {
        HDZKAddWithPhoneViewController *addPhoneVC = [[HDZKAddWithPhoneViewController alloc] init];
        [self.navigationController pushViewController:addPhoneVC animated:YES];
    }];
    
    PopoverAction *action2 = [PopoverAction actionWithTitle:NSLocalizedString(@"二维码添加", nil) handler:^(PopoverAction *action) {
        YZBLScanViewController *scanVC = [[YZBLScanViewController alloc] init];
        scanVC.style = [StyleDIY ZhiFuBaoStyle];
        scanVC.isVideoZoom = YES;//镜头拉远拉近功能
        [self.navigationController pushViewController:scanVC animated:YES];
        
    }];
    
    PopoverAction *action3 = [PopoverAction actionWithTitle:NSLocalizedString(@"我的二维码", nil) handler:^(PopoverAction *action) {
        YZBLMyQRCodeViewController *myCodeVC = [[YZBLMyQRCodeViewController alloc] init];
        [self.navigationController pushViewController:myCodeVC animated:YES];
        
    }];
    
    PopoverView *popoverView = [PopoverView popoverView];
    popoverView.showShade = YES; // 显示阴影背景
    
    [popoverView showToPoint:CGPointMake(kScreenW-35, 64)  withActions:@[action1,action2,action3]];
}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
