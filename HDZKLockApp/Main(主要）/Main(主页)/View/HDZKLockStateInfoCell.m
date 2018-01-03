//
//  HDZKLockStateInfoCell.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/25.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLockStateInfoCell.h"
#import "UIButton+Layout.h"

@interface HDZKLockStateInfoCell()

@property (weak, nonatomic) IBOutlet UIButton *tipButton;

@property (weak, nonatomic) IBOutlet UIButton *elePowerButton;

@property (weak, nonatomic) IBOutlet UIButton *bleStateButton;

@property (weak, nonatomic) IBOutlet UIButton *networkStateButton;

@property (nonatomic, weak) NSTimer* timer;

@end



@implementation HDZKLockStateInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    [_tipButton layoutButtonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_elePowerButton layoutButtonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_bleStateButton layoutButtonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleTop imageTitleSpace:5];
    [_networkStateButton layoutButtonWithEdgeInsetsStyle:BRButtonEdgeInsetsStyleTop imageTitleSpace:5];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - action

- (IBAction)lockStateEvent:(UIButton *)sender {
    
 
    if (_stateButtonBlock) {
        
        _stateButtonBlock([NSNumber numberWithInteger:sender.tag]);
    }
    
}



- (void)begainConnactBle{
    //定时器模拟闪烁动画效果
   _timer =  [NSTimer scheduledTimerWithTimeInterval:0.8f repeats:YES block:^(NSTimer * _Nonnull timer) {
        _bleStateButton.selected = !_bleStateButton.selected;
    }];
    [_timer fire];
   
}



- (void)dealloc{
    
     [_timer invalidate];
    
}


@end
