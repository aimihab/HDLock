//
//  BLSettingCell.h
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BLSettingItem;
@interface BLSettingCell : UITableViewCell

@property (nonatomic, strong) BLSettingItem *item;
/** switch状态改变的block*/
@property (copy, nonatomic) void(^switchChangeBlock)(BOOL on);

@property (copy, nonatomic) void(^buttonSelectedBlock)(BOOL selected);

@property (copy, nonatomic) void(^buttonPullDownBlock)(BOOL selected);

+ (id)settingCellWithTableView:(UITableView *)tableView;



@end
