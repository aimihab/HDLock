//
//  HDZKSetMyInfoViewController.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/15.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKSetMyInfoViewController.h"

#import "HDZKUserService.h"

#import "YZBLImagePicker.h"
#import "LBXAlertAction.h"
#import "SDImageCache.h"

@interface HDZKSetMyInfoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *iconHeadImageButton;

@property (weak, nonatomic) IBOutlet UITextField *InputUserNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;



@property (strong, nonatomic) YZBLImagePicker *picker;

@end

@implementation HDZKSetMyInfoViewController

#pragma mark - getter
-(YZBLImagePicker *)picker
{
    if (!_picker) {
        _picker = [YZBLImagePicker new];
        _picker.size = CGSizeMake(400, 400);
        _picker.enableEditing = YES;
        _picker.superVc = self;
        YZWeakSelf(weakSelf,self);
        [_picker setResult:^(BOOL canceled, UIImage *img) {
            if (!canceled) {
                YZStrongSelf(strongSelf, weakSelf);
                [MBProgressHUD showActivityMessageInView:@"上传头像中.."];
                [YZUserModelInstance updateHeadImage:img suffix:@"png" success:^(NSString *fileUrl) {
                    [MBProgressHUD hideHUD];
                    [[SDImageCache sharedImageCache] removeImageForKey:YZUserModelInstance.u_head_url withCompletion:nil];
                    YZUserModelInstance.u_head_url = [NSString stringWithFormat:@"%@?%@",fileUrl,@([[NSDate date] timeIntervalSince1970])];
                    
                } failure:^(YZUserError *error) {
                    [MBProgressHUD hideHUD];
                    [MBProgressHUD showErrorMessage:NSLocalizedString(@"上传头像失败", nil)];
                }];
            }
        }];
    }
    return _picker;
}


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    _InputUserNameTextField.layer.borderWidth = 1.0f;
    _InputUserNameTextField.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    _InputUserNameTextField.layer.cornerRadius = _InputUserNameTextField.height/2;
    _InputUserNameTextField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,10,_InputUserNameTextField.height)];
    _InputUserNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    _confirmButton.clipsToBounds = YES;
    _confirmButton.layer.cornerRadius = _confirmButton.height/2;

}

#pragma mark- action

- (IBAction)upLoadImageButtonEvent:(UIButton *)sender {
    
    [LBXAlertAction showActionSheetWithTitle:nil message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitle:@[@"拍照",@"手机相册"] chooseBlock:^(NSInteger buttonIdx) {
        
        DLog(@"...点击%ld",buttonIdx);
        if (buttonIdx == 1) {
            
            [self.picker chooseFromLibrary];
        }else if (buttonIdx == 2){
            
             [self.picker chooseFromCamera];
        }
    }];
    
    
}


- (IBAction)confirmButtonEvent:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    if ([_InputUserNameTextField.text isBlankString]) {
        [MBProgressHUD showInfoMessage:@"请填写昵称~"];
        return;
    }else if (!YZUserModelInstance.u_head_url){
        [MBProgressHUD showInfoMessage:@"请上传头像~"];
        return;
    }
    
    YZUserModel *model = YZUserModelInstance;
    model.u_nick_name = _InputUserNameTextField.text;
    
    [HDZKUserService editUserWithModel:model success:^{
        
        DLog(@"保存用户信息成功..");
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(2)];
        
    } failure:^(YZUserError *error) {
        
        [MBProgressHUD showErrorMessage:error.localizedDescription];
    }];
    
}



#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


#pragma mark - super Method

- (void)backItemEvent:(UIBarButtonItem *)sender{
    
     [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(2)];
    
}


@end
