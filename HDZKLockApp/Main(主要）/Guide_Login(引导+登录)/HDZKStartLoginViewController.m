//
//  HDZKStartLoginViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/12.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKStartLoginViewController.h"
#import "HDZKLoginViewController.h"

@interface HDZKStartLoginViewController ()

@end

@implementation HDZKStartLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
}



- (IBAction)startLoginEvent:(UIButton *)sender {
    
    HDZKLoginViewController *loginVC = [[HDZKLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
    
    
}





@end
