//
//  HDZKBaseSetViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/16.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKBaseSetViewController.h"

@interface HDZKBaseSetViewController ()

@end

@implementation HDZKBaseSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backItemEvent:)];
    
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"currency_top_icon_back_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
}

- (void)backItemEvent:(UIBarButtonItem *)sender{
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}



#pragma mark - UITableViewDelagate
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10.0f;
    }
    return 30.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 30.0f;
}

*/




@end
