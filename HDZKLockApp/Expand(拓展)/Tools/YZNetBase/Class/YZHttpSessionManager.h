//
//  YZHttpSessionManager.h
//  YZNetBaseDemo
//
//  Created by 包月兴 on 2017/11/20.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YZHttpSessionManager : AFHTTPSessionManager

+(instancetype)shareSessionManager;

@end
