//
//  BLSettingGroup.h
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLSettingGroup : NSObject
@property (nonatomic, copy) NSString *header; // 头部标题
@property (nonatomic, copy) NSString *footer; // 尾部标题
@property (nonatomic, strong) NSArray *items; // 中间的条目


@end
