//
//  AppMacro.h
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//  app相关的宏定义

#import "HDZKBaseViewController.h"
#import "HDZKBaseNavController.h"


#import "YZUserModel.h"
#import "YZMacro.h"

#import <YYCache.h>
#import "UIView+Extension.h"
#import "NSString+Check.h"
#import "UIColor+Extension.h"
#import "MBProgressHUD+LQEncapsulation.h"
#import "UIImageView+AFNetworking.h"
#import "UIAlertView+Extension.h"
#import <BabyBluetooth.h>



#define APPICONIMAGE [UIImage imageNamed:[[[[NSBundle mainBundle] infoDictionary] valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject]]
#define APPNAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]


#pragma mark - -------------------------常用宏-------------------------

//RGB颜色
#define KColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//RGB颜色+透明度
#define KRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//随机色
#define KRandomColor KColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//RGB（十六进制色值）
#define BLRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define HZLockMainColor    [UIColor stringTOColor:@"#00D57C"]//锁主题色
#define HZImportantTextColor    [UIColor stringTOColor:@"#050c1a"]//重要文字颜色
#define HZSecondaryTextColor    [UIColor stringTOColor:@"#a4a9b2"]//次要文字颜色
#define HZWeakeningTextColor    [UIColor stringTOColor:@"#d3d9e5"]//弱化文字颜色
#define HZDividerTextColor      [UIColor stringTOColor:@"#ebecf0"]//分割线颜色
#define HZOverallBackGroundColor    [UIColor stringTOColor:@"#fafbff"]//整体背景色
#define HZWakeupColor               [UIColor stringTOColor:@"#f0635b"]//惊醒色
#define YZBL_COLOR_C3 [UIColor stringTOColor:@"#d3d9e5"]


#define Default_Person_Image [UIImage imageNamed:@"default_parents"]
#define Default_General_Image [UIImage imageNamed:@"default_general"]

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height



#define HDZKNotificationCenter [NSNotificationCenter defaultCenter]
#define HDZKUserDefault [NSUserDefaults standardUserDefaults]


// 判断是否为 iPhone 5SE
#define iPhone5SE [[UIScreen mainScreen] bounds].size.width == 320.0f && [[UIScreen mainScreen] bounds].size.height == 568.0f
// 判断是否为iPhone 6/6s
#define iPhone6_6s [[UIScreen mainScreen] bounds].size.width == 375.0f && [[UIScreen mainScreen] bounds].size.height == 667.0f
// 判断是否为iPhone Plus/Plus
#define IS_IPHONE_P [[UIScreen mainScreen] bounds].size.width == 414.0f && [[UIScreen mainScreen] bounds].size.height == 736.0f

//UUID
#define UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]


//自定义Log
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);


#define UserLockDataCache [YYCache cacheWithName:@"UserDataCache"]
#define BindLockListKey [NSString stringWithFormat:@"%@_bandLockList",YZUserModelInstance.u_id]
#define AuthorLockListKey [NSString stringWithFormat:@"%@_authorLockList",YZUserModelInstance.u_id]
#define CurrentLockModelKey [NSString stringWithFormat:@"%@_CurrentLockModel",YZUserModelInstance.u_id]

