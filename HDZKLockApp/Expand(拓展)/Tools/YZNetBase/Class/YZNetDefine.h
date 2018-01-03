//
//  YZNetDefine.h
//  YZBleBaseDemo
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#ifndef YZNetDefine_h
#define YZNetDefine_h

#define LOG_LEVEL_DEF ddLogLevel


typedef NS_ENUM(NSUInteger,YZNetErrorCode){
    YZNetErrorCodeNoNetwork = 1, //无网络
    YZNetErrorCodeNetworkError, //网络错误
    YZNetErrorCodeSignError,
    YZNetErrorCodeLackSystemParameters,
    YZNetErrorCodeLackBusinessParameters,
    YZNetErrorCodeRequestOverdue,
};



#ifdef DEBUG 

//     ---------调试 ----------
#define openHttpsSSL NO   //开启https ssl验证


#else

//     ----------发布打包-------------
#define openHttpsSSL YES   //关闭https ssl验证
#endif



#endif /* YZNetDefine_h */



