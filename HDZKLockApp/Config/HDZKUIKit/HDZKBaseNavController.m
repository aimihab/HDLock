//
//  HDZKBaseNavController.m
//  HDZKLockApp
//
//  Created by lq on 2017/5/15.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKBaseNavController.h"
#import "UIViewController+MMDrawerController.h"

@interface HDZKBaseNavController ()

@end

@implementation HDZKBaseNavController




- (void)viewDidLoad {
    
    [super viewDidLoad];

    /*
     UIImage *backButtonImage = [[UIImage imageNamed:@"currency_top_icon_back_gray"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
    UIBarButtonItem *backItem = [UIBarButtonItem appearance];
    [backItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [backItem setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    */
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.tintColor = HZImportantTextColor;
    
    
}

+ (void)initialize{

    if (self == [HDZKBaseNavController class]) {
        
        UINavigationBar *navBar = [UINavigationBar appearance];
        [navBar setBackIndicatorImage:[UIImage imageNamed:@"currency_top_icon_back_gray"]];
        
     //  navBar.translucent =
    }

}

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.mm_drawerController.showsStatusBarBackgroundView){
        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleDefault;
    }
}

@end
