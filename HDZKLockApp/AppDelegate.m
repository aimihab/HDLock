//
//  AppDelegate.m
//  HDZKLockApp
//
//  Created by lq on 17/5/15.
//  Copyright © 2017年 yzkj-HDZK. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Service.h"
//#import "AppDelegate+RootController.h"


#import "HDZKLoginViewController.h"
#import "HDZKMainViewController.h"
#import "HDZKLeftSideViewController.h"


#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"



@interface AppDelegate()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [YZUserModelInstance setDomain:HDDOMAIN versionType:YZUserVersionTypeDevelop isHttps:ISUSERHTTPS];//配置域名接口环境
    
    //注册登录状态监听布局UI
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:LoginStateChangeNotification
                                               object:nil];
    
    if (YZUserModelInstance.isLogin) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(1)];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:LoginStateChangeNotification object:@(0)];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - private
- (void)setMainContentController{
    
    HDZKLeftSideViewController *leftVC = [[HDZKLeftSideViewController alloc] init];
    HDZKBaseNavController *leftNav = [[HDZKBaseNavController alloc] initWithRootViewController:leftVC];
    [leftNav setRestorationIdentifier:@"HDZKLeftNavigationControllerRestorationKey"];
    
    HDZKMainViewController *centerVC = [[HDZKMainViewController alloc] init];
    HDZKBaseNavController *centerNav = [[HDZKBaseNavController alloc] initWithRootViewController:centerVC];
    [centerNav setRestorationIdentifier:@"HDZKMainNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:centerNav leftDrawerViewController:leftNav];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:[AppDelegate leftViewWith]];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
}


- (void)loginStateChange:(NSNotification *)notification{
    
    NSInteger loginSuccess = [notification.object integerValue];
    switch (loginSuccess) {
        case 0://未登录 (启动第一次未登录，退出登录)
        {
            if (self.drawerController) {
                [self.drawerController.navigationController popToRootViewControllerAnimated:NO];
            }
            [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
            self.drawerController = nil;
            HDZKLoginViewController *loginVC = [[HDZKLoginViewController alloc] init];
            self.window.rootViewController = [[HDZKBaseNavController alloc] initWithRootViewController:loginVC];
            
        }
            break;
        case 1://已登录
        {
            if (self.drawerController == nil) {
                [self setMainContentController];
            }
            [self.window setRootViewController:self.drawerController];
        }
            break;
        case 2://未登录->已登录
        {
            if (self.drawerController == nil) {
                [self setMainContentController];
            }
             [self.window setRootViewController:self.drawerController];
        }
            break;
        
        default:
            break;
    }
    
}


#pragma mark - public
+ (CGFloat)leftViewWith{
    
    CGFloat w = 260.0f;
    
    if(iPhone6_6s){
        w = 300.0f;
    }else if(IS_IPHONE_P){
        w = 320.0f;
    }else{
        w = 260.0f;
    }
    return w;
}

#pragma mark - other
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
