//
//  HDZKLockStateInfoCell.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/25.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDZKLockStateInfoCell : UITableViewCell

@property (nonatomic ,copy)CoreSuccess stateButtonBlock;


- (void)begainConnactBle;

@end
