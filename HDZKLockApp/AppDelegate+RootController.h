//
//  AppDelegate+RootController.h
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)

/**
 * 首次启动轮播图
 */
-(void)createLoadingScrollView;

/**
 * tabBar实例
 */
-(void)setTabBarController;


/**
 * 根视图
 */
-(void)setRootViewController;

@end
