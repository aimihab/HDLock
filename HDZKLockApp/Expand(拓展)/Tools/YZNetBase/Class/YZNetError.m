//
//  YZNetError.m
//  YZBleBaseDemo
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "YZNetError.h"

@implementation YZNetError


-(instancetype)init
{
    return nil;
}
-(instancetype)initWithErrorCode:(YZNetErrorCode)code
{
    NSString *description  = @"";
    switch (code) {
        case YZNetErrorCodeNoNetwork:
            description = @"无网络";
            break;
        case YZNetErrorCodeNetworkError:
            description = @"网络错误";
            break;
        case YZNetErrorCodeSignError:
            description = @"签名算法错误";
            break;
        case YZNetErrorCodeLackSystemParameters:
            description = @"系统参数错误";
            break;
        case YZNetErrorCodeLackBusinessParameters:
            description = @"业务参数错误";
            break;
        case YZNetErrorCodeRequestOverdue:
            description = @"请求过期";
            break;
        default:
            break;
    }
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    if (self = [super initWithDomain:@"com.szbailiao.network" code:code userInfo:userInfo]) {
        
    }
    return self;
    
}

-(instancetype)initWithErrorCode:(NSInteger)code withDescription:(NSString *)description
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:description forKey:NSLocalizedDescriptionKey];
    if (self = [super initWithDomain:@"com.szbailiao.network" code:code userInfo:userInfo]) {
        
    }
    return self;
}

@end
