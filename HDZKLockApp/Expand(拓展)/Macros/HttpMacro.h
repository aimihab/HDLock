//
//  HttpMacro.h
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//  定义一些网络请求url相关的宏、常量


//测试环境
#define HOST_TEST
//正式环境
//#define HOST_PRODUCT


#ifdef HOST_TEST

#define HDDOMAIN @"test.api.hdzkong.com"
#define ISUSERHTTPS NO
#define APIVERSION @"v1"
static NSString *QINIUHEADURL = @"http://ounwevhul.bkt.clouddn.com/";

#else

#define HDDOMAIN @"test.api.hdzkong.com"
#define APIVERSION @"v1"
#define ISUSERHTTPS NO
static NSString *QINIUHEADURL = @"http://ounwevhul.bkt.clouddn.com/";

#endif





