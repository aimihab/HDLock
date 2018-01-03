//
//  YZNetManager.m
//  YZBleBaseDemo
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "YZNetManager.h"
#import "YZNetDefine.h"
#import "YZNetError.h"
#import <AFNetworking.h>
#import <AFHTTPSessionManager+Synchronous.h>
#import <Reachability.h>
#import <NSString+EncryptSha.h>
#import <JSONKit.h>
#import "YZHttpSessionManager.h"

@implementation YZNetManager

#pragma mark   异步POST 请求
+(void)networkPostRequestWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(void (^)(id))success failure:(void (^)(YZNetError *))failure
{
    if (![self p_checkNetwork]) {
        if (failure) {
            YZNetError *error = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNoNetwork];
            failure(error);
        }
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    NSDate *now = [NSDate date];
    NSInteger time = [now timeIntervalSince1970];
    [dic setObject:@(time) forKey:@"timestamp"];
    NSString *c_sum = [self p_createSignWithDictionary:dic];
    [dic setObject:c_sum forKey:@"c_sum"];
    AFHTTPSessionManager *manager = [YZHttpSessionManager shareSessionManager];
    [manager.requestSerializer setTimeoutInterval:3];
    if (openHttpsSSL) {
        [manager setSecurityPolicy:[self p_customSecurityPolicy]];
    }
    [manager POST:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self p_parseError:error failure:failure];
    }];
}


#pragma mark  异步GET 请求
+(void)networkGetRequestWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(void (^)(id))success failure:(void (^)(YZNetError *))failure
{
    if (![self p_checkNetwork]) {
        if (failure) {
            YZNetError *error = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNoNetwork];
            failure(error);
        }
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    NSDate *now = [NSDate date];
    NSTimeInterval time = [now timeIntervalSince1970];
    [dic setObject:@(time) forKey:@"timestamp"];
    NSString *c_sum = [self p_createSignWithDictionary:dic];
    [dic setObject:c_sum forKey:@"c_sum"];
    AFHTTPSessionManager *manager = [YZHttpSessionManager shareSessionManager];
    [manager.requestSerializer setTimeoutInterval:3];
    if (openHttpsSSL) {
        [manager setSecurityPolicy:[self p_customSecurityPolicy]];
    }
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [self p_parseError:error failure:failure];
    }];
    
}



#pragma mark --- 同步POST请求

+(void)networkSyncPostRequestWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(void (^)(id))success failure:(void (^)(YZNetError *))failure
{
    if (![self p_checkNetwork]) {
        if (failure) {
            YZNetError *error = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNoNetwork];
            failure(error);
        }
        return;
    }
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    NSDate *now = [NSDate date];
    NSTimeInterval time = [now timeIntervalSince1970];
    [dic setObject:@(time) forKey:@"timestamp"];
    NSString *c_sum = [self p_createSignWithDictionary:dic];
    [dic setObject:c_sum forKey:@"c_sum"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:3];
    if (openHttpsSSL) {
        [manager setSecurityPolicy:[self p_customSecurityPolicy]];
    }
    
    
    
    
}



#pragma mark  解析错误信息
+(void)p_parseError:(NSError *)error failure:(void (^)(YZNetError *))failure
{
    if (error && failure) {
         YZNetError *netError;
        if ([error.userInfo allKeys].count <=2) {
            netError = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNetworkError];
            failure(netError);
            return;
        }
        if ([[error.userInfo allValues][2] isKindOfClass:[NSData class]]) {
            NSData* jsonData = [error.userInfo allValues][2];
            NSDictionary *jsonDic = [jsonData objectFromJSONData];
            NSArray *keys = [jsonDic allKeys];
            if ([keys containsObject:@"code"] && [keys containsObject:@"msg"]) {
                NSInteger code = [jsonDic[@"code"] integerValue];
                NSString *msg = jsonDic[@"msg"];
                DLog(@"%@",msg);
                netError = [[YZNetError alloc] initWithErrorCode:code withDescription:msg];
            }else
            {
                netError = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNetworkError];
            }
        }else
        {
             netError = [[YZNetError alloc] initWithErrorCode:YZNetErrorCodeNetworkError];
        }
        failure(netError);
 
    }
}



#pragma mark 检查网络
+(BOOL)p_checkNetwork{
    
    Reachability *reachabilityManager = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (reachabilityManager.isReachable) {
        return YES;
    }
    return NO;
}

#pragma mark 生成签名
+ (NSString *)p_createSignWithDictionary:(NSMutableDictionary *)signDict
{
    NSMutableArray *keyArr = [NSMutableArray arrayWithArray:[signDict allKeys]];
    [keyArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult result = [obj1 compare:obj2 options:NSCaseInsensitiveSearch];
        return result==NSOrderedDescending;
    }];
    NSMutableString *str = [NSMutableString string];
    for (NSInteger i=0 ;i<keyArr.count;i++) {
        NSString *key = keyArr[i];
        [str appendFormat:@"%@=%@&", key, signDict[key]];
    }
    NSString *privatekey = @"v1_xkl_2017";
    NSString *signStr = [NSString stringWithFormat:@"%@&%@%@", privatekey,str, privatekey];
    return [signStr encryptSha256];
}


#pragma mark https SSL
+ (AFSecurityPolicy*)p_customSecurityPolicy{
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"pem"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    // securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}


@end
