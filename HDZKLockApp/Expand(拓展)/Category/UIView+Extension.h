//
//  UIView+Extension.h
//  APPProject
//
//  Created by lq on 16/2/17.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic,assign) CGFloat left;
@property (nonatomic,assign) CGFloat top;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGPoint origin;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;


/*
 * Shake view animation
 */
+ (void)shakeAnimationWithView:(UIView *)view;

/*
 * Set the view disable, when disable is equal to YES, the view will be uninteractive.
 */
- (void)viewWaiting:(BOOL)waiting;

@end
