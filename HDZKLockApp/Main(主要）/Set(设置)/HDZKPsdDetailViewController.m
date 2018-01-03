//
//  HDZKPsdDetailViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/16.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKPsdDetailViewController.h"
#import "BLPasswordView.h"

@interface HDZKPsdDetailViewController ()

@property (nonatomic, strong) BLPasswordView *setPasswordView;
@end

@implementation HDZKPsdDetailViewController


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = HZOverallBackGroundColor;
    self.title = NSLocalizedString(@"密码设置", nil);

    self.setPasswordView = [[BLPasswordView alloc] initWithFrame:CGRectMake(16, 100, self.view.frame.size.width - 32, 45)];
    [self.view addSubview:self.setPasswordView];
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
