//
//  YZNetManager.h
//  YZBleBaseDemo
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZNetError.h"
@interface YZNetManager : NSObject

#pragma mark --- 异步POST请求
+(void)networkPostRequestWithParameter:(NSDictionary *)parameter
                              url:(NSString *)url
                               success:(void (^)(id responseObject))success
                               failure:(void(^)(YZNetError *error))failure;

#pragma mark --- 异步GET请求
+(void)networkGetRequestWithParameter:(NSDictionary *)parameter
                              url:(NSString *)url
                               success:(void (^)(id responseObject))success
                               failure:(void(^)(YZNetError *error))failure;



#pragma mark --- 同步POST请求
+(void)networkSyncPostRequestWithParameter:(NSDictionary *)parameter
                                       url:(NSString *)url
                                   success:(void (^)(id responseObject))success
                                   failure:(void(^)(YZNetError *error))failure;


#pragma mark --- 同步GET请求

+(void)networkSyncGetRequestWithParameter:(NSDictionary *)parameter
                                  url:(NSString *)url
                              success:(void (^)(id responseObject))success
                              failure:(void(^)(YZNetError *error))failure;


@end
