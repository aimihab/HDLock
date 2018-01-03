//
//  TLTableViewController.h
//  TLChat
//
//  Created by lq on 16/1/23.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELLDEFAULTHEIGHT 50.0f

@interface YZBLTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *analyzeTitle;

@property (strong, nonatomic) UITableView *tableView;



@end
