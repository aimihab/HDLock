//
//  YZBLPHeadCell.h
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import <UIKit/UIKit.h>
@class userModel;
@interface YZBLPHeadCell : UITableViewCell
-(void)refrshModel:(YZUserModel *)userModel;
-(void)refrshImage:(UIImage *)image;
@end
