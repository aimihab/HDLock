//
//  BLPasswordView.h
//  PasswordDemo
//
//  Created by lq on 2017/8/6.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLPasswordView : UIView<UITextFieldDelegate>

/**
 *  清除密码
 */
- (void)clearUpPassword;

/**
 实际输入框
 */
@property (nonatomic, strong) UITextField *textField;


@end
