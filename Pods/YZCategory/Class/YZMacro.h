//
//  YZMacro.h
//  YZCategory
//
//  Created by baoyx on 2017/5/18.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#ifndef YZMacro_h
#define YZMacro_h
//单例宏
#define SingletonH + (instancetype)sharedInstance;

#define SingletonM \
static id _instance; \
+ (instancetype)sharedInstance \
{ \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \

//NSUserDefaults操作宏

//获取值
#define YZ_UDGetObj(KEY) [[NSUserDefaults standardUserDefaults] objectForKey:(KEY)]
//设置值
#define YZ_UDSetObj(OBJ,KEY)  [[NSUserDefaults standardUserDefaults] setObject:(OBJ) forKey:(KEY)]; [[NSUserDefaults standardUserDefaults] synchronize]
//删除值
#define YZ_UDDeleteObj(KEY)[[NSUserDefaults standardUserDefaults] removeObjectForKey:(KEY)];[[NSUserDefaults standardUserDefaults] synchronize]


//多语言适配
#define YZLocalizedString(key) \
NSLocalizedString(key,nil)

//同步主线程宏
#define dispatch_sync_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

//异步主线程宏
#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define YZWeakSelf(VAR,OBJ) __weak typeof(OBJ) VAR = OBJ
#define YZStrongSelf(VAR,OBJ) __strong typeof(OBJ) VAR = OBJ









#endif /* YZMacro_h */
