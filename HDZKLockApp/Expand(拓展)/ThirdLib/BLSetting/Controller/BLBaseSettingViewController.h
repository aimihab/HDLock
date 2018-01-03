//
//  BLBaseSettingViewController.h
//  BLSetting
//
//  Created by lq on 15/9/19.
//  Copyright (c) 2015 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BLSettingGroup.h"
#import "BLSettingItem.h"

@interface BLBaseSettingViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *allGroups;

@property (nonatomic , strong) UITableView *tableView;

@end
