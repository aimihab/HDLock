//
//  UINavigationController+LQProgress.m
//  ProgressDemo
//
//  Created by lq on 2017/12/20.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "UINavigationController+LQProgress.h"

NSInteger const LQProgresstagId = 222122323;
NSInteger const LQProgressMasktagId = 221222322;
NSInteger const LQProgressMiniMasktagId = 221222321;
CGFloat const LQProgressBarHeight = 2.5;

@implementation UINavigationController (LQProgress)

- (CGRect)getLQMaskFrame
{
    float navBarHeight = self.navigationBar.frame.size.height;
    float navBarY = self.navigationBar.frame.origin.y;
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height - navBarHeight - navBarY;
    float x = 0;
    float y = navBarHeight + navBarY;
    
    return CGRectMake(x, y, width, height);
}

- (CGRect)getLQMiniMaskFrame
{
    float width = self.navigationBar.frame.size.width;
    float height = self.navigationBar.frame.size.height + self.navigationBar.frame.origin.y - LQProgressBarHeight;
    
    return CGRectMake(0, 0, width, height);
}

- (UIColor *)getLQMaskColor
{
    return [UIColor colorWithWhite:0 alpha:0.4];
}

- (UIView *)setupLQProgressSubview
{
    return [self setupLQProgressSubviewWithTintColor:self.navigationBar.tintColor];
}

- (UIView *)setupLQProgressSubviewWithTintColor:(UIColor *)tintColor
{
    float y = self.navigationBar.frame.size.height - LQProgressBarHeight;
    
    UIView *progressView;
    for (UIView *subview in [self.navigationBar subviews])
    {
        if (subview.tag == LQProgresstagId)
        {
            progressView = subview;
        }
    }
    
    if(!progressView)
    {
        progressView = [[UIView alloc] initWithFrame:CGRectMake(0, y, 0, LQProgressBarHeight)];
        progressView.tag = LQProgresstagId;
        progressView.backgroundColor = tintColor;
        [self.navigationBar addSubview:progressView];
    }
    else
    {
        CGRect progressFrame = progressView.frame;
        progressFrame.origin.y = y;
        progressView.frame = progressFrame;
    }
    
    return progressView;
}

- (void)setupLQProgressMask
{
    UIView *mask;
    UIView *miniMask;
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag == LQProgressMasktagId)
        {
            mask = subview;
        }
        
        if (subview.tag == LQProgressMiniMasktagId)
        {
            miniMask = subview;
        }
    }
    
    if(!mask)
    {
        mask = [[UIView alloc] initWithFrame:[self getLQMaskFrame]];
        mask.tag = LQProgressMasktagId;
        mask.backgroundColor = [self getLQMaskColor];
        mask.alpha = 0;
        
        miniMask = [[UIView alloc] initWithFrame:[self getLQMiniMaskFrame]];
        miniMask.tag = LQProgressMiniMasktagId;
        miniMask.backgroundColor = [self getLQMaskColor];
        miniMask.alpha = 0;
        
        [self.view addSubview:mask];
        [self.view addSubview:miniMask];
        [UIView animateWithDuration:0.2 animations:^{
            mask.alpha = 1;
            miniMask.alpha = 1;
        }];
    }
    else
    {
        mask.frame = [self getLQMaskFrame];
        miniMask.frame = [self getLQMiniMaskFrame];
    }
}

- (void)removeLQMask
{
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag == LQProgressMasktagId || subview.tag == LQProgressMiniMasktagId)
        {
            [UIView animateWithDuration:0.3 animations:^{
                subview.alpha = 0;
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
                self.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
            }];
        }
    }
}

- (void)resetTitle
{
    BOOL titleChanged = [[[NSUserDefaults standardUserDefaults] objectForKey:kLQProgressTitleChanged] boolValue];
    
    if(titleChanged)
    {
        NSString *oldTitle = [[NSUserDefaults standardUserDefaults] objectForKey:kLQProgressOldTitle];
        //add animation
        self.visibleViewController.navigationItem.title = oldTitle;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kLQProgressTitleChanged];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLQProgressOldTitle];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)changeLQProgressWithTitle:(NSString *)title
{
    BOOL titleAlreadyChanged = [[[NSUserDefaults standardUserDefaults] objectForKey:kLQProgressTitleChanged] boolValue];
    if(!titleAlreadyChanged)
    {
        NSString *oldTitle = self.visibleViewController.navigationItem.title;
        [[NSUserDefaults standardUserDefaults] setObject:oldTitle forKey:kLQProgressOldTitle];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kLQProgressTitleChanged];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //add animation
        self.visibleViewController.navigationItem.title = title;
    }
}

- (void)setTintModeAndSetupMask
{
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [self setupLQProgressMask];
}

- (void)viewUpdatesForPercentage:(float)percentage andTintColor:(UIColor *)tintColor
{
    UIView *progressView = [self setupLQProgressSubviewWithTintColor:tintColor];
    float maxWidth = self.navigationBar.frame.size.width;
    float progressWidth = maxWidth * (percentage / 100);
    
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect progressFrame = progressView.frame;
        progressFrame.size.width = progressWidth;
        progressView.frame = progressFrame;
        
    } completion:^(BOOL finished)
     {
         if(percentage >= 100.0)
         {
             [UIView animateWithDuration:0.5 animations:^{
                 progressView.alpha = 0;
             } completion:^(BOOL finished) {
                 [progressView removeFromSuperview];
                 [self removeLQMask];
                 [self resetTitle];
             }];
         }
     }];
}

#pragma mark user functions
- (void)showLQProgress
{
    [self showLQProgressWithDuration:3];
}

- (void)showLQProgressWithDuration:(float)duration
{
    [self showLQProgressWithDuration:duration andTintColor:self.navigationBar.tintColor];
}

- (void)showLQProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor andTitle:(NSString *)title
{
    [self changeLQProgressWithTitle:title];
    [self showLQProgressWithDuration:duration andTintColor:tintColor];
}

- (void)showLQProgressWithDuration:(float)duration andTintColor:(UIColor *)tintColor
{
    UIView *progressView = [self setupLQProgressSubviewWithTintColor:tintColor];
    
    float maxWidth = self.navigationBar.frame.size.width;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGRect progressFrame = progressView.frame;
        progressFrame.size.width = maxWidth;
        progressView.frame = progressFrame;
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            progressView.alpha = 0;
        } completion:^(BOOL finished) {
            [progressView removeFromSuperview];
            [self removeLQMask];
            [self resetTitle];
        }];
    }];
}

- (void)showLQProgressWithMaskAndDuration:(float)duration andTitle:(NSString *) title
{
    [self changeLQProgressWithTitle:title];
    [self showLQProgressWithMaskAndDuration:duration];
    
}

- (void)showLQProgressWithMaskAndDuration:(float)duration
{
    UIColor *tintColor = self.navigationBar.tintColor;
    self.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    [self setupLQProgressMask];
    [self showLQProgressWithDuration:duration andTintColor:tintColor];
    
}

- (void)finishLQProgress
{
    UIView *progressView = [self setupLQProgressSubview];
    
    if(progressView)
    {
        [UIView animateWithDuration:0.1 animations:^{
            CGRect progressFrame = progressView.frame;
            progressFrame.size.width = progressFrame.size.width + 1;
            progressView.frame = progressFrame;
        }];
    }
}

- (void)cancelLQProgress {
    UIView *progressView = [self setupLQProgressSubview];
    
    if(progressView)
    {
        [UIView animateWithDuration:0.5 animations:^{
            progressView.alpha = 0;
        } completion:^(BOOL finished) {
            [progressView removeFromSuperview];
            [self removeLQMask];
            [self resetTitle];
        }];
    }
}

- (void)setLQProgressMaskWithPercentage:(float)percentage
{
    UIColor *tintColor = self.navigationBar.tintColor;
    
    if([NSThread isMainThread])
    {
        [self setTintModeAndSetupMask];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setTintModeAndSetupMask];
        });
    }
    
    [self setLQProgressPercentage:percentage andTintColor:tintColor];
}

- (void)setLQProgressMaskWithPercentage:(float)percentage andTitle:(NSString *)title
{
    [self changeLQProgressWithTitle:title];
    [self setLQProgressMaskWithPercentage:percentage];
}

- (void)setLQProgressPercentage:(float)percentage
{
    [self setLQProgressPercentage:percentage andTintColor:self.navigationBar.tintColor];
}

- (void)setLQProgressPercentage:(float)percentage andTitle:(NSString *)title
{
    [self changeLQProgressWithTitle:title];
    [self setLQProgressPercentage:percentage andTintColor:self.navigationBar.tintColor];
}

- (void)setLQProgressPercentage:(float)percentage andTintColor:(UIColor *)tintColor
{
    if (percentage > 100.0)
    {
        percentage = 100.0;
    }
    else if(percentage < 0)
    {
        percentage = 0;
    }
    
    if([NSThread isMainThread])
    {
        [self viewUpdatesForPercentage:percentage andTintColor:tintColor];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self viewUpdatesForPercentage:percentage andTintColor:tintColor];
        });
    }
}


@end
