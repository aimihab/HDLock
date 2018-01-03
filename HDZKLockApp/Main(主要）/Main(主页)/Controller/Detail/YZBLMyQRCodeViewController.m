//
//  YZBLMyQRCodeViewController.m
//  BLChat
//
//  Created by lq on 2017/5/24.
//
//

#import "YZBLMyQRCodeViewController.h"
#import "LBXAlertAction.h"
#import "LBXScanNative.h"
#import "UIImageView+CornerRadius.h"
#import "NSDictionary+String.h"
#import "YZUserModel.h"

@interface YZBLMyQRCodeViewController ()


//二维码
@property (nonatomic, strong) UIView *qrView;
@property (nonatomic, strong) UIImageView* qrImgView;
@property (nonatomic, strong) UIImageView* logoImgView;

@end

@implementation YZBLMyQRCodeViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = NSLocalizedString(@"我的二维码", nil);
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //二维码视图UI
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake( (CGRectGetWidth(self.view.frame)-CGRectGetWidth(self.view.frame)*5/6)/2, 100, CGRectGetWidth(self.view.frame)*5/6, CGRectGetWidth(self.view.frame)*5/6)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowOffset = CGSizeMake(0, 2);
    view.layer.shadowRadius = 2;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.5;
    
    self.qrImgView = [[UIImageView alloc]init];
    _qrImgView.bounds = CGRectMake(0, 0, CGRectGetWidth(view.frame)-12, CGRectGetWidth(view.frame)-12);
    _qrImgView.center = CGPointMake(CGRectGetWidth(view.frame)/2, CGRectGetHeight(view.frame)/2);
    [view addSubview:_qrImgView];
    self.qrView = view;
    
    //创建二维码
    [self createMyQR_logo];
    
}


/**
 生成二维码图像
 */
- (void)createMyQR_logo{
    

    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setObject:[NSNumber numberWithInt:1] forKey:@"type"];
    [dataDic setObject:YZUserModelInstance.openid forKey:@"open_id"];
    [dataDic setObject:YZUserModelInstance.u_id forKey:@"u_id"];
    
    NSString *jsonStr = [dataDic jsonRequestString];
    _qrView.hidden = NO;
    _qrImgView.image = [LBXScanNative createQRWithString:jsonStr QRSize:_qrImgView.bounds.size];
    
#if 0
     //头像logo
    CGSize logoSize=CGSizeMake(30, 30);
    self.logoImgView = [self roundCornerWithImage:[UIImage imageNamed:@"logo"] size:logoSize];
    _logoImgView.bounds = CGRectMake(0, 0, logoSize.width, logoSize.height);
    _logoImgView.center = CGPointMake(CGRectGetWidth(_qrImgView.frame)/2, CGRectGetHeight(_qrImgView.frame)/2);
    [_qrImgView addSubview:_logoImgView];
    
#endif
    
}

/**
 头像logo定制

 @param logoImg 头像图片
 @param size 大小
 @return 带logo头像的二维码图片
 */
- (UIImageView*)roundCornerWithImage:(UIImage*)logoImg size:(CGSize)size
{
    //logo圆角
    UIImageView *backImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    backImage.frame = CGRectMake(0, 0, size.width, size.height);
    backImage.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logImage = [[UIImageView alloc] initWithCornerRadiusAdvance:6.0f rectCornerType:UIRectCornerAllCorners];
    logImage.image =logoImg;
    CGFloat diff  =2;
    logImage.frame = CGRectMake(diff, diff, size.width - 2 * diff, size.height - 2 * diff);
    
    [backImage addSubview:logImage];
    
    return backImage;
}
- (void)createQR_color
{
    _qrView.hidden = NO;
     _qrImgView.image = [LBXScanNative createQRWithString:@"" QRSize:_qrImgView.bounds.size QRColor:[UIColor blueColor] bkColor:[UIColor whiteColor]];
}
#pragma mark - 错误提示
- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str buttonsStatement:@[@"知道了"] chooseBlock:nil];
}


@end
