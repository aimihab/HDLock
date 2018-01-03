//
//  VendorMacro.h
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//  第三方常量配置


#define UmengAppKey @"550a9500fd98c55ab1000f57"//友盟appKey
#define ShareQQAppID @"1104418201"//腾讯appID
#define ShareQQAppKey @"ypxK0NC3YD3ZbagT"//腾讯appKey
#define WetChatAppId @"wx7b1afe37e90787fc"//微信appID
#define WetChatAppSecret @"2bd06ca54d0aca139be9f6e89c04355f"//微信appSecret
#define SMSMobAppKey @"683feb4e2540"//MobAppKey
#define SMSMobAppSecret @"8ad765a4dae8d2d2948ff72944b0d8a0"
#define SMSMobAppKeyTest @"114ed22f249fe"//MobAppKey--测试使用
#define SMSMobAppSecretTest @"59c4b7aa8864140c2512acfaeb81e063"
#define BuglyKey @"900021400"//崩溃日志上报

#define JpushKey [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"JpushKey"]
#define IsProduction [[[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SchoolConfig.plist" ofType:nil]] objectForKey:@"IsProduction"]

#define CrashReportAppKey @"900021400"
