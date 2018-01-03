//
//  HDZKLockInfoViewCell.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/22.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLockInfoViewCell.h"

@interface HDZKLockInfoViewCell()

@property (weak, nonatomic) IBOutlet UIButton *authorKeyBtn;

@property (weak, nonatomic) IBOutlet UIButton *authorUserBtn;

@property (weak, nonatomic) IBOutlet UIButton *normalRecordsBtn;


@end


@implementation HDZKLockInfoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _authorKeyBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _authorUserBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _normalRecordsBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [_authorKeyBtn setTitle:[NSString stringWithFormat:@"   0把\n%@",@"授权钥匙"] forState:UIControlStateNormal];
    [_authorUserBtn setTitle:[NSString stringWithFormat:@"   0人\n%@",@"授权用户"] forState:UIControlStateNormal];
    [_normalRecordsBtn setTitle:[NSString stringWithFormat:@"   正常\n%@",@"开锁记录"] forState:UIControlStateNormal];
}



- (IBAction)buttonEvent:(UIButton *)sender {
    
    
    if (_infoViewEventBlock) {
        _infoViewEventBlock([NSNumber numberWithInteger:sender.tag]);
    }
    

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
