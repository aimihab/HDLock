//
//  HDZKAddWithPhoneViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/23.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKAddWithPhoneViewController.h"
#import "HDZKAuthorUserDetailViewController.h"

#import "UIView+BorderLine.h"

@interface HDZKAddWithPhoneViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;


@end

@implementation HDZKAddWithPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"手机号码添加", nil);
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [_inputTextField borderForColor:[UIColor groupTableViewBackgroundColor] borderWidth:1.0f borderType:UIBorderSideTypeBottom];
    _nextButton.clipsToBounds = YES;
    _nextButton.layer.cornerRadius = _nextButton.height/2;
    [_nextButton addTarget:self action:@selector(nextEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextEvent:(UIButton *)sender{
    
    if (![_inputTextField.text checkTelNumber]) {
        [MBProgressHUD showWarnMessage:NSLocalizedString(@"请输入正确的手机号码", nil)];
        return;
    }
    
    HDZKAuthorUserDetailViewController *userDetailVC = [[HDZKAuthorUserDetailViewController alloc] init];
    [self.navigationController pushViewController:userDetailVC animated:YES];
    
}



#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}



@end
