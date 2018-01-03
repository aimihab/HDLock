//
//  YZBLPHeadCell.m
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import "YZBLPHeadCell.h"
#import "HDZKUserService.h"
@interface YZBLPHeadCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation YZBLPHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _headImage.layer.cornerRadius = _headImage.width/2;
    _headImage.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refrshModel:(YZUserModel *)userModel
{
    NSString *url = [HDZKUserService headUrlWithUserModel:userModel];
    [_headImage setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon_morentouxian"]];
    
    
}


-(void)refrshImage:(UIImage *)image
{
    _headImage.image = image;
}



@end
