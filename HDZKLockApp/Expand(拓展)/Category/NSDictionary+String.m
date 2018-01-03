//
//  NSDictionary+String.m
//  network
//
//  Created by tengqingqing on 14-12-10.
//  Copyright (c) 2014年 ysp. All rights reserved.
//

#import "NSDictionary+String.h"


@implementation NSDictionary (String)

- (NSString *)jsonRequestString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

+ (NSDictionary *)dictionaryWithString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *JsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JsonData options:NSJSONReadingMutableContainers error:&err];
    
    
//    使用JSONKit解析方法
//    NSDictionary *responseJSON = [NSDictionary dictionary];
//    responseJSON = [jsonString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    NSLog(@"返回数据为%@..",responseJSON);
    if (err) {
        NSLog(@"解析失败..");
        return nil;
    }
    return responseJSON;
}

@end
