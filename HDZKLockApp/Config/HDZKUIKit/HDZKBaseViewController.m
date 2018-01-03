//
//  HDZKRootViewController.m
//  HDZKLockApp
//
//  Created by lq on 17/5/4.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//

#import "HDZKBaseViewController.h"

@interface HDZKBaseViewController ()

@end

@implementation HDZKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(backItemEvent:)];
    [self.navigationItem.leftBarButtonItem setImage:[[UIImage imageNamed:@"currency_top_icon_back_gray"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.navigationController.navigationBar.tintColor = HZSecondaryTextColor;
    
}


#pragma mark - method

- (void)backItemEvent:(UIBarButtonItem *)sender{
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
         [self.navigationController popViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
