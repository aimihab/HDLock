//
//  AppDelegate+RootController.m
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//

#import "AppDelegate+RootController.h"

#import "HDZKLoginViewController.h"
#import "HDZKMainViewController.h"
#import "HDZKLeftSideViewController.h"


#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"


@interface AppDelegate()

@property (nonatomic,strong) MMDrawerController *drawerController;

@end


@implementation AppDelegate (RootController)


-(void)createLoadingScrollView
{
    DLog(@"引导页设置..如果需要");
    
}

-(void)setTabBarController
{
    DLog(@"底部导航栏设置..如果需要");
}





-(void)setRootViewController
{
    
    if (![YZUserModelInstance isLogin]) {

        HDZKLeftSideViewController *leftVC = [[HDZKLeftSideViewController alloc] init];
        HDZKBaseNavController *leftNav = [[HDZKBaseNavController alloc] initWithRootViewController:leftVC];
        [leftNav setRestorationIdentifier:@"HDZKLeftNavigationControllerRestorationKey"];
        
        HDZKMainViewController *centerVC = [[HDZKMainViewController alloc] init];
        HDZKBaseNavController *centerNav = [[HDZKBaseNavController alloc] initWithRootViewController:centerVC];
        [centerNav setRestorationIdentifier:@"HDZKMainNavigationControllerRestorationKey"];
        
        self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNav leftDrawerViewController:leftNav];
       [self.drawerController setShowsShadow:NO];
        [self.drawerController setRestorationIdentifier:@"MMDrawer"];
        [self.drawerController setMaximumLeftDrawerWidth:200.0];
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
    
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
         
       [self.window setRootViewController:self.drawerController];


    }else{
    
        HDZKLoginViewController *loginVC = [[HDZKLoginViewController alloc] init];
        self.window.rootViewController = [[HDZKBaseNavController alloc] initWithRootViewController:loginVC];

    }
    

    
}



- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
        
    }else if ([key isEqualToString:@"HDZKMainNavigationControllerRestorationKey"]) {
        
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }else if ([key isEqualToString:@"HDZKLeftNavigationControllerRestorationKey"]) {
        
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    
    return nil;

}






@end
