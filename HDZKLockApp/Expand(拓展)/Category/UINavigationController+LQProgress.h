//
//  UINavigationController+LQProgress.h
//  ProgressDemo
//
//  Created by lq on 2017/12/20.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLQProgressTitleChanged @"kLQProgressTitleChanged"
#define kLQProgressOldTitle @"kLQProgressOldTitle"

@interface UINavigationController(LQProgress)

- (void)showLQProgress;
- (void)showLQProgressWithDuration:(float)duration;
- (void)showLQProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor;
- (void)showLQProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title;
- (void)showLQProgressWithMaskAndDuration:(float)duration;
- (void)showLQProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title;


- (void)setLQProgressPercentage:(float)percentage;
- (void)setLQProgressPercentage:(float)percentage andTitle:(NSString *)title;
- (void)setLQProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor;
- (void)setLQProgressMaskWithPercentage:(float)percentage;
- (void)setLQProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title;


- (void)finishLQProgress;
- (void)cancelLQProgress;

@end
