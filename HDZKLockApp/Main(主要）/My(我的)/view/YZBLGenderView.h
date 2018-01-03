//
//  YZBLGenderView.h
//  BLChat
//
//  Created by baoyx on 2017/6/10.
//
//

#import <UIKit/UIKit.h>

@interface YZBLGenderView : UIView
@property (copy,nonatomic) void(^genderEvent)(YZGenderType genderType);
@property (copy, nonatomic) void(^genderCancelEvent)();
@end
