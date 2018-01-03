//
//  YZBLMyQrCodeViewController.m
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import "YZBLMyQrCodeViewController.h"
#import "LBXAlertAction.h"
#import "LBXScanNative.h"
#import "UIImageView+CornerRadius.h"
#import "NSDictionary+String.h"

@interface YZBLMyQrCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;


@property (nonatomic, strong) UIView *qrView;
@property (nonatomic, strong) UIImageView* qrImgView;
@property (nonatomic, strong) UIImageView* logoImgView;
@end

@implementation YZBLMyQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"我的二维码",nil);
   // self.view.backgroundColor = HZOverallBackGroundColor;
    [self p_initUI];
}


-(void)p_initUI
{
    _headView.layer.cornerRadius = _headView.width/2;
    _headView.layer.masksToBounds = YES;
    NSString *url = YZUserModelInstance.u_head_url;
    if (!url || [url isEqualToString:@"http://xx.com/img.png"] || [url isEqualToString:@""]) {
        url = [NSString stringWithFormat:@"%@%@.png",QINIUHEADURL,YZUserModelInstance.u_id];
    }
    
    [_headView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_morentouxian"]];
    _nickNameLabel.text = YZUserModelInstance.u_nick_name;

 
    CGFloat viewHeight = 186.0f;
    if (iPhone6_6s) {
        viewHeight = 200.0f;
    }else if(IS_IPHONE_P){
        viewHeight = 220.0f;
    }
    CGFloat x = (kScreenW - viewHeight)/2;
    CGFloat y = _lineView.y + _lineView.height + 45;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x,y,viewHeight,viewHeight)];
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
    
   // _bottomLabel.frame = CGRectMake(0, y+viewHeight+10, kScreenW, 21);
    
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
