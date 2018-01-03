//
//  QuickBuild.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/21.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "QuickBuild.h"

@implementation QuickBuild


+ (UILabel *)quickBuildLableWithFrame:(CGRect)frame text:(NSString *)text color:(UIColor *)color font:(UIFont *)font  textAlignment:(NSTextAlignment)textAlignment {
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = text;
    
    label.textColor = color;
    
    label.font = font;
    
    label.textAlignment = textAlignment;
    
    label.backgroundColor = [UIColor clearColor];
    
    
    
    return label;
    
}





+ (UITextField *)quickBuildTextFieldWithFrame:(CGRect)frame  placeholder:(NSString *)placeholder color:(UIColor *)color font:(UIFont *)font  secureTextEntry:(BOOL)secureTextEntry  delegate:(id)delegate {
    
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    
    textField.placeholder = placeholder;
    
    textField.textColor = color;
    
    textField.font = font;
    
    textField.secureTextEntry = secureTextEntry;
    
    textField.delegate = delegate;
    
    
    
    return textField;
    
}



+ (UITextView *)quickBuildTextViewWithFrame:(CGRect)frame  text:(NSString *)text   color:(UIColor *)color  font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    
    textView.text = text;
    
    textView.textColor = color;
    
    textView.textAlignment = textAlignment;
    
    
    
    textView.backgroundColor = [UIColor clearColor];
    
    textView.editable = NO;
    
    textView.scrollEnabled = NO;
    
    textView.dataDetectorTypes =UIDataDetectorTypeLink;
    
    
    
    return textView;
    
}





+ (UIButton *)quickBuildButtonWithFrame:(CGRect)frame  title:(NSString *)title  color:(UIColor *)color font:(UIFont *)font  backgroundImage:(UIImage *)backgroundImage  target:(id)target  action:(SEL)action {
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    [btn.titleLabel setFont:font];
    
    
    
    [btn setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return btn;
    
}





+ (UIImageView*) quickBuildImageViewWithFrame:(CGRect)frame image:(UIImage*)image {
    
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
    
    imgView.contentMode =UIViewContentModeScaleAspectFill;
    
    imgView.image = image;
    
    
    
    return imgView;
    
}



+ (UIImage*) quickBuildimageWithColor:(UIColor*)color {
    
    
    CGSize imageSize = CGSizeMake(1, 1);
    
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    
    [color set];
    
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}




@end
