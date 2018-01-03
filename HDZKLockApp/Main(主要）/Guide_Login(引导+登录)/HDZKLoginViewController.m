//
//  HDZKLoginViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/12.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLoginViewController.h"
#import "HDZKSetMyInfoViewController.h"

#import "JKCountDownButton.h"
#import "UITextField+shake.h"
#import "HDZKUserService.h"

@interface HDZKLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userPhoneTextField;


@property (weak, nonatomic) IBOutlet UITextField *authorCodeTextField;


@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@property (weak, nonatomic) IBOutlet UILabel *describedLabel;


/**
 获取验证码
 */
@property (weak, nonatomic) IBOutlet JKCountDownButton *getAuthCodeBtn;

@end

@implementation HDZKLoginViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    UIView *backgroundView = [self.navigationController.navigationBar subviews].firstObject;
    UIView *_navLine = backgroundView.subviews.firstObject;
    _navLine.hidden = YES;

    
    _userPhoneTextField.layer.borderWidth = 1.0f;
    _userPhoneTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _userPhoneTextField.layer.cornerRadius = _userPhoneTextField.height/2;
    _userPhoneTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,10,_userPhoneTextField.height)];
    _userPhoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _authorCodeTextField.layer.borderWidth = 1.0f;
    _authorCodeTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _authorCodeTextField.layer.cornerRadius = _authorCodeTextField.height/2;
    _authorCodeTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,10,_userPhoneTextField.height)];
    _authorCodeTextField.leftViewMode = UITextFieldViewModeAlways;

    _loginButton.clipsToBounds = YES;
    _loginButton.layer.cornerRadius = _loginButton.height/2;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_getAuthCodeBtn.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(_getAuthCodeBtn.height/2, _getAuthCodeBtn.height/2)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _getAuthCodeBtn.bounds;
    maskLayer.path = maskPath.CGPath;
    _getAuthCodeBtn.layer.mask = maskLayer;
    
}

#pragma mark - action


- (IBAction)getAuthorCode:(JKCountDownButton *)sender {
    
    if (![_userPhoneTextField.text checkTelNumber]) {//校验手机号
        [_userPhoneTextField shake];
        _userPhoneTextField.layer.borderColor = [UIColor redColor].CGColor;
        [_userPhoneTextField becomeFirstResponder];
        return;
    }else{
         _userPhoneTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }
    
    
    [HDZKUserService loginVerificationCodeWithPhone:_userPhoneTextField.text success:^(NSString *code) {
        
        _authorCodeTextField.text = code;
        [_authorCodeTextField becomeFirstResponder];
        
        sender.enabled = NO;
        [sender startCountDownWithSecond:60];
        
        [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            _getAuthCodeBtn.backgroundColor = [UIColor grayColor];
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            _getAuthCodeBtn.backgroundColor = HZLockMainColor;
            return NSLocalizedString(@"重新获取", nil);
        }];
        
    } failure:^(YZUserError *error) {
        DLog(@"获取失败..");
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
    
}



- (IBAction)loginEvent:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (![_userPhoneTextField.text checkTelNumber]) {//校验手机号
        [_userPhoneTextField shake];
        _userPhoneTextField.layer.borderColor = [UIColor redColor].CGColor;
        [_userPhoneTextField becomeFirstResponder];
        return;
    }else if ([_authorCodeTextField.text length] != 4 && [_authorCodeTextField.text length] != 6){//校验登录验证码
        [MBProgressHUD showErrorMessage:NSLocalizedString(@"请输入正确的验证码", nil)];
        [_authorCodeTextField becomeFirstResponder];
        return;
    }
   
    
    [MBProgressHUD showActivityMessageInView:@"正在登录.."];
    [HDZKUserService loginWithPhone:_userPhoneTextField.text code:_authorCodeTextField.text success:^(BOOL hasPassword) {
        [MBProgressHUD hideHUD];
        NSLog(@"登录成功..");
        if ([YZUserModelInstance.u_head_url isBlankString] || [YZUserModelInstance.u_nick_name isBlankString]) {
            HDZKSetMyInfoViewController *setInfoVC = [[HDZKSetMyInfoViewController alloc] init];
            [self.navigationController pushViewController:setInfoVC animated:YES];
        }else{
             [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(2)];
        }
    
    } failure:^(YZUserError *error) {
        [MBProgressHUD hideHUD];
        DLog(@"登录失败....%@",error);
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
    
}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _userPhoneTextField ) {
        
        if ([textField.text checkTelNumber]) {
             _userPhoneTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
        }else{
            [_userPhoneTextField shake];
            _userPhoneTextField.layer.borderColor = [UIColor redColor].CGColor;
            [_userPhoneTextField becomeFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userPhoneTextField) {
        [_userPhoneTextField resignFirstResponder];
        [_authorCodeTextField becomeFirstResponder];
    } else if (textField == _authorCodeTextField) {
        [_authorCodeTextField resignFirstResponder];
    }
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (textField == _userPhoneTextField && [textField.text checkTelNumber]) {
        _userPhoneTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    }

    return YES;
}


#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


@end
