//
//  BLSettingItem.h
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015年 lq. All rights reserved.
//  一个Item对应一个Cell
// 用来描述当前cell里面显示的内容，描述点击cell后做什么事情

#import <Foundation/Foundation.h>

typedef enum : NSInteger{
    BLSettingItemTypeNone, // 什么也没有
    BLSettingItemTypeArrow, // 箭头
    BLSettingItemTypeSwitch, // 开关
    BLSettingItemTypeSelect,  //选择
    BLSettingItemTypePullDown, //下拉
    
} BLSettingItemType;

@interface BLSettingItem : NSObject


/**
 基础配置
 */
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BLSettingItemType type;


/**
 业务配置
 */
@property (nonatomic , copy) NSString *detailText;
@property (nonatomic, assign) BOOL isSwitchOn; //开关状态
@property (nonatomic,assign) BOOL isCellSelected; //cell被选中状态


/** cell上开关的操作事件 */
@property (nonatomic, copy) void (^switchBlock)(BOOL on);

/**
 点击cell后要执行的BLock
 */
@property (nonatomic, copy) void (^operation)();

/**
 选中按钮执行的Block
 */
@property (nonatomic, copy) void (^buttonBlock)(BOOL selected);

//初始化
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(BLSettingItemType)type;



@end
