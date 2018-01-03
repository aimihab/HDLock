//
//  YZBLNickNameViewController.m
//  BLChat
//
//  Created by lq on 2017/6/10.
//
//

#import "YZBLNickNameViewController.h"
#import "HDZKLockModel.h"

@interface YZBLNickNameViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) UITextField *tagTextField;
@property (strong, nonatomic) UIView *tagBackView;
@property (nonatomic , assign) ModifyType modifyType;

@end

static CGFloat navBarHeight = 64.0f;
@implementation YZBLNickNameViewController


#pragma mark - 初始化

- (instancetype)initWithType:(ModifyType)type{
    
    self = [super init];
    
    if (self) {
        _modifyType = type;
    }
        
    return self;
}


/**
 若是修改锁名称

 @param lockModel 锁数据模型
 */
- (void)setLockModel:(HDZKLockModel *)lockModel{
    
    _lockModel = lockModel;
    _nickName = lockModel.dev_name;
    
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"昵称",nil);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tagBackView = self.tagBackView;
    _tagTextField = self.tagTextField;
    [self.tagTextField becomeFirstResponder];
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"保存", nil) style:UIBarButtonItemStyleDone target:self action:@selector(saveEvent:)];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor darkGrayColor] forKey:NSForegroundColorAttributeName];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
#pragma mark - getter

-(UIView *)tagBackView
{
    if (_tagBackView == nil) {
        _tagBackView = [[UIView alloc] initWithFrame:CGRectMake(0,15+navBarHeight, kScreenW,50)];
        _tagBackView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tagBackView];
    }
    return _tagBackView;
}


-(UITextField *)tagTextField
{
    if (_tagTextField == nil) {
        _tagTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,10,kScreenW-20, 30)];
        _tagTextField.text = _nickName;
        [_tagTextField setFont:[UIFont systemFontOfSize:14]];
        [_tagTextField setTextColor:KRGBACOLOR(0x45,0x45,0x53,1)];
        _tagTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tagTextField.returnKeyType = UIReturnKeyDone;
        _tagTextField.delegate = self;
        [_tagTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self.tagBackView addSubview:_tagTextField];
    }
    return _tagTextField;
}



#pragma mark - action

- (void)textFieldDidChange:(UITextField *)textField {
    
    if ([textField.text isEqualToString:_nickName]) {//未修改
        self.navigationItem.rightBarButtonItem.enabled = NO;
        NSDictionary *dic = [NSDictionary dictionaryWithObject:YZBL_COLOR_C3 forKey:NSForegroundColorAttributeName];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    }else{//已修改
        self.navigationItem.rightBarButtonItem.enabled = YES;
        NSDictionary *dic = [NSDictionary dictionaryWithObject:HZImportantTextColor forKey:NSForegroundColorAttributeName];
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:dic forState:UIControlStateNormal];
    }
    if (textField.text.length > 20) {
        textField.text = [textField.text substringToIndex:20];
        [textField resignFirstResponder];//键盘缩回
        [MBProgressHUD showErrorMessage:NSLocalizedString(@"您输入的昵称超过字数限制!", nil)];
    }
}

- (void)saveEvent:(UIBarButtonItem *)sender{

    __block NSString *modifyName = self.tagTextField.text;
    if ([modifyName isEqualToString:@""]){
        [MBProgressHUD showErrorMessage:NSLocalizedString(@"没有输入昵称，请重新填写", nil)];
        return;
    }

    if (_modifyType == ModifyTypeLock) {//修改锁名称
        
        //修改锁名称API
        if (_gainNickName) {
            _gainNickName(modifyName);
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }else{ //设置自己的昵称
        
        if (_gainNickName) {
            _gainNickName(modifyName);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];// 使当前文本框失去第一响应者的特权，就会回收键盘了
    return YES;
}



//隐藏键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_tagTextField resignFirstResponder];
}


@end
