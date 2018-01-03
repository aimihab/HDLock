//
//  YZHttpSessionManager.m
//  YZNetBaseDemo
//
//  Created by 包月兴 on 2017/11/20.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "YZHttpSessionManager.h"
#import "YZNetDefine.h"

@implementation YZHttpSessionManager

+(instancetype)shareSessionManager
{
    static YZHttpSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [YZHttpSessionManager manager];
    });
    return _manager;
}

@end
