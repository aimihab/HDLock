//
//  YZBLOpinionViewController.m
//  BLChat
//
//  Created by 包月兴 on 2017/8/3.
//
//

#import "YZBLOpinionViewController.h"

@interface YZBLOpinionViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIScrollView *scr;
@property (strong, nonatomic) UITextView *textview;
@property (strong, nonatomic) UILabel *placeholder;
@property (strong, nonatomic) UILabel *contactLabel;
@property (strong, nonatomic) UIView *contactBackground;
@property (strong, nonatomic) UITextField *contact;
@end

@implementation YZBLOpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =  NSLocalizedString(@"意见反馈",nil);
    self.view.backgroundColor = HZOverallBackGroundColor;
    UIBarButtonItem *submitBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"提交",nil) style:UIBarButtonItemStylePlain target:self action:@selector(submitEvent)];
    self.navigationItem.rightBarButtonItem= submitBtn;
    
    // UI controls
    _textview = self.textview;
    _placeholder = self.placeholder;
    _contactLabel = self.contactLabel;
    _contactBackground = self.contactBackground;
    _contact = self.contact;
    [self addObserver];
}



#pragma mark - property settings
- (UIScrollView *)scr {
    if (_scr == nil) {
        _scr = [[UIScrollView alloc]init];
        [self.view addSubview:_scr];
        [_scr setShowsHorizontalScrollIndicator:NO];
        [_scr setShowsVerticalScrollIndicator:NO];
        [_scr setContentSize:self.view.frame.size];
        [_scr setContentInset:(UIEdgeInsetsMake(0, 0, -20, 0))];
        _scr.frame = self.view.frame;
    }
    return _scr;
}

- (UITextView *)textview {
    if (!_textview) {
        _textview = [[UITextView alloc]init];
        [self.scr addSubview:_textview];
        _textview.delegate = self;
        _textview.frame = CGRectMake(0,0,kScreenW, 180);
        _textview.font = [UIFont systemFontOfSize:14];
        _textview.textColor = KRGBACOLOR(0x45, 0x45, 0x53, 1);
        _textview.backgroundColor = [UIColor whiteColor];
        _textview.textContainerInset = UIEdgeInsetsMake(18, 0, 18, 0);
        _textview.textContainer.lineFragmentPadding = 15;
        [_textview setReturnKeyType:(UIReturnKeyDone)];
        _textview.layer.borderColor = KRGBACOLOR(234, 234, 237, 1).CGColor;
        _textview.layer.borderWidth = 1;
    }
    return _textview;
}

- (UILabel *)placeholder {
    if (!_placeholder) {
        _placeholder = [UILabel new];
        [self.scr insertSubview:_placeholder aboveSubview:self.textview];
         [_placeholder setTextColor:KRGBACOLOR(0xac, 0xb2, 0xb9, 1)];
        [_placeholder setFont:[UIFont systemFontOfSize:14]];
        _placeholder.text = NSLocalizedString(@"请描述您遇到的问题，我们会仔细聆听",nil);
        [_placeholder sizeToFit];
        _placeholder.y = self.textview.y+20;
        _placeholder.x = self.textview.x+15;
    }
    return _placeholder;
}

- (UILabel *)contactLabel {
    if (!_contactLabel) {
        _contactLabel = [UILabel new];
        [self.scr addSubview:_contactLabel];
        [_contactLabel setTextColor:KRGBACOLOR(0xac, 0xb2, 0xb9, 1)];
        [_contactLabel setFont:[UIFont systemFontOfSize:14]];
        _contactLabel.text = NSLocalizedString(@"请留下您的联系方式，",nil);
        [_contactLabel sizeToFit];
        _contactLabel.y = self.textview.y+self.textview.height+18;
        _contactLabel.x = 15;
    }
    return _contactLabel;
}

- (UITextField *)contact {
    if (!_contact) {
        _contact = [UITextField new];
        [self.scr addSubview:_contact];
        [_contact setFont:[UIFont systemFontOfSize:14]];
        [_contact setPlaceholder:NSLocalizedString(@"QQ/邮箱/手机",nil)];
        [_contact setClearButtonMode:(UITextFieldViewModeWhileEditing)];
        [_contact setBorderStyle:(UITextBorderStyleNone)];
        [_contact setKeyboardType:(UIKeyboardTypeEmailAddress)];
        [_contact setReturnKeyType:(UIReturnKeyDone)];
        [_contact addTarget:self action:@selector(done:) forControlEvents:(UIControlEventEditingDidEndOnExit)];
        _contact.textColor = KRGBACOLOR(0x45, 0x45, 0x53, 1);
        _contact.frame = CGRectMake(15, self.contactBackground.y, self.contactBackground.width-30, self.contactBackground.height);
    }
    return _contact;
}

- (UIView *)contactBackground {
    if (!_contactBackground) {
        _contactBackground = [UIView new];
        [self.scr addSubview:_contactBackground];
        _contactBackground.backgroundColor = [UIColor whiteColor];
        _contactBackground.frame = CGRectMake(0, self.contactLabel.y+self.contactLabel.height+8, kScreenW, 45);
        _contactBackground.layer.borderColor = KRGBACOLOR(234, 234, 237, 1).CGColor;
        _contactBackground.layer.borderWidth = 1;
    }
    return _contactBackground;
}



- (void)done:(UITextField *)tf {
    [tf resignFirstResponder];
}

#pragma mark - notification
- (void)textViewDidChangeNotification:(NSNotification *)noti {
    if (self.textview.isFirstResponder) {
        // 处理开头加四个空格
        NSRange range = [YZBLOpinionViewController rangeOfSpaceCharOnHeadWithString:self.textview.text];
        if(range.length>0) {
            self.textview.text = [self.textview.text stringByReplacingCharactersInRange:range withString:@""];
        }
        // 设置placeholder状态
        if (!self.textview.text || !self.textview.text.length) {
            self.placeholder.hidden = NO;
        }else{
            self.placeholder.hidden = YES;
        }
    }else{
        // 处理开头加四个空格
        NSRange range = [YZBLOpinionViewController rangeOfSpaceCharOnHeadWithString:self.contact.text];
        if(range.length>0) {
            self.contact.text = [self.contact.text stringByReplacingCharactersInRange:range withString:@""];
        }
    }
}

- (void)keyboardwillChange:(NSNotification *)noti {
    NSDictionary *dic       = noti.userInfo;
    CGRect showRect         = [dic[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration        = [dic[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    NSInteger animationInfo = [dic[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    [UIView animateWithDuration:duration delay:0 options:animationInfo animations:^{
        self.scr.frame = CGRectMake(0, 0, self.view.width, self.view.height-showRect.size.height);
        self.scr.contentSize = CGSizeMake(self.view.width, self.contact.y+self.contact.height+40);
    } completion:^(BOOL finished) {
        nil;
    }];
}

#pragma mark - UITextViewDelegate delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.textview resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - function implementations
- (void)addObserver {
    // Observe keyboard change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeNotification:) name:NSTextStorageDidProcessEditingNotification object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (NSRange)rangeOfSpaceCharOnHeadWithString:(NSString *)str {
    NSString *pattern = @"^\\s+";
    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray<NSTextCheckingResult *> *result = [regExp matchesInString:str options:NSMatchingReportCompletion range:NSMakeRange(0, [str length])];
    return result.firstObject.range;
}


#pragma mark ############----events---#############

-(void)submitEvent
{
    // 获取描述和联系方式
    NSString *content = self.textview.text? self.textview.text:@"";
    NSString *contact = self.contact.text? self.contact.text:@"";
    if (content.length<=0) {
        [UIView shakeAnimationWithView:self.textview];
        return;
    }else if (contact.length<=0) {
        [UIView shakeAnimationWithView:self.contact];
        return;
    }
    //感谢您的宝贵意见，您的反馈已经提交，我们会尽快处理。
    [UIAlertView showAlertViewWithTitle:NSLocalizedString(@"提交成功", nil) message:NSLocalizedString(@"😊感谢您对慧点智控的关注和支持，我们会第一时间处理您的反馈。", nil) cancelButtonTitle:NSLocalizedString(@"返回上一页", nil) otherButtonTitles:nil onDismiss:^(int buttonIndex) {
        
    } onCancel:^{
         [self.navigationController popViewControllerAnimated:YES];
    }];
    

}



@end
