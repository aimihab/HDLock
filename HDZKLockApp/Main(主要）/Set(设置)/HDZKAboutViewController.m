//
//  HDZKAboutViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/16.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKAboutViewController.h"
#import "UIView+BorderLine.h"

@interface HDZKAboutViewController ()

@property (weak, nonatomic) IBOutlet UILabel *describedLabel;

@property (weak, nonatomic) IBOutlet UILabel *telphoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *telphoneButton;


@end

@implementation HDZKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = HZOverallBackGroundColor;
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    [_describedLabel borderForColor:[UIColor groupTableViewBackgroundColor] borderWidth:2 borderType:UIBorderSideTypeTop | UIBorderSideTypeBottom];
    
    [_telphoneLabel borderForColor:[UIColor groupTableViewBackgroundColor] borderWidth:2 borderType:UIBorderSideTypeTop | UIBorderSideTypeBottom];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)callPhoneNumberEvent:(UIButton *)sender {
    
    DLog(@"拨打电话..");
    
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
