//
//  BLSettingItem.m
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import "BLSettingItem.h"



@implementation BLSettingItem

+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title type:(BLSettingItemType)type
{
    BLSettingItem *item = [[self alloc] init];
    item.icon = icon;
    item.title = title;
    item.type = type;
    
    if ([icon isEqualToString:@"btn_duoxuan_s"]) {
        item.isCellSelected = YES;
    }else if([icon isEqualToString:@"btn_duoxuan_n"]){
        item.isCellSelected = NO;
    }
   
    item.isSwitchOn = YES;//默认都为YES
    return item;
    
}




@end
