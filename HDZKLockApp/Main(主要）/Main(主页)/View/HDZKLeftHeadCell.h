//
//  HDZKLeftHeadCell.h
//  HDZKLockApp
//
//  Created by lq on 2017/7/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YZUserModel;


@interface HDZKLeftHeadCell : UITableViewCell


@property (nonatomic,copy) void(^tapAvatarBlock)();
/**
 刷新cell

 @param userModel 用户对象
 */
-(void)refrshUIWithUserMoel:(YZUserModel *)userModel;

@end
