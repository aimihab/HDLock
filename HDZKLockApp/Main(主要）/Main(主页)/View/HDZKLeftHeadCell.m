//
//  HDZKLeftHeadCell.m
//  HDZKLockApp
//
//  Created by lq on 2017/7/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKLeftHeadCell.h"
#import "HDZKUserService.h"

@interface HDZKLeftHeadCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation HDZKLeftHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headImageView.layer.cornerRadius = _headImageView.frame.size.width/2;
    _headImageView.layer.masksToBounds = YES;
    _headImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAvatarView:)];
    [_headImageView addGestureRecognizer:tap];
    
}


-(void)refrshUIWithUserMoel:(YZUserModel *)userModel{
    
    [_headImageView setImageWithURL:[NSURL URLWithString:userModel.u_head_url] placeholderImage:[UIImage imageNamed:@"icon_morentouxian"]];
    
    if (![userModel.u_nick_name isBlankString]) {
        _nickNameLabel.text = userModel.u_nick_name;
    }
    if (![userModel.bind_phone isBlankString]) {
        _phoneLabel.text = userModel.bind_phone;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)tapAvatarView:(UITapGestureRecognizer *)sender{
    if (_tapAvatarBlock) {
        _tapAvatarBlock();
    }
}

@end
