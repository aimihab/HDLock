//
//  YZNetError.h
//  YZBleBaseDemo
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZNetDefine.h"

@interface YZNetError : NSError

-(instancetype)initWithErrorCode:(YZNetErrorCode)code;

-(instancetype)initWithErrorCode:(NSInteger)code withDescription:(NSString *)description;

@end
