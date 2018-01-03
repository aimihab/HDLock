//
//  YZBLScanViewController.h
//  BLChat
//
//  Created by lq on 2017/5/24.
//
//

#import <UIKit/UIKit.h>

#import "LBXScanView.h"

#import "LBXScanNative.h"


@interface YZBLScanViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


/**
 @brief 是否需要扫码图像
 */
@property (nonatomic, assign) BOOL isNeedScanImage;
/**
 @brief  扫码功能封装对象
 */
@property (nonatomic,strong) LBXScanNative* scanObj;

#pragma mark - 扫码界面效果及提示等
/**
 @brief  扫码区域视图,二维码一般都是框
 */
@property (nonatomic,strong) LBXScanView* qRScanView;


/**
 *  界面效果参数
 */
@property (nonatomic, strong) LBXScanViewStyle *style;


/**
 @brief  扫码存储的当前图片
 */
@property(nonatomic,strong)UIImage* scanImage;



/**
 @brief  启动区域识别功能
 */
@property(nonatomic,assign)BOOL isOpenInterestRect;


/**
 @brief  闪关灯开启状态
 */
@property(nonatomic,assign)BOOL isOpenFlash;


//打开相册
- (void)openLocalPhoto;
//开关闪光灯
- (void)openOrCloseFlash;


//子类继承必须实现的提示
/**
 *  继承者实现的alert提示功能
 *
 *  @param str 提示语
 */
- (void)showError:(NSString*)str;


- (void)reStartDevice;



/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

#pragma mark --增加拉近/远视频界面
@property (nonatomic, assign) BOOL isVideoZoom;

#pragma mark - 底部几个功能：开启闪光灯、相册、我的二维码
//底部显示的功能项
@property (nonatomic, strong) UIView *bottomItemsView;
//相册
@property (nonatomic, strong) UIButton *btnPhoto;
//闪光灯
@property (nonatomic, strong) UIButton *btnFlash;
//我的二维码
@property (nonatomic, strong) UIButton *btnMyQR;


@end
