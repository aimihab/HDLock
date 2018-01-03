//
//  YZBLNickNameViewController.h
//  BLChat
//
//  Created by lq on 2017/6/10.
//
//

#import "HDZKBaseViewController.h"

typedef NS_ENUM(NSInteger,ModifyType){
    ModifyTypeMine = 0,//修改用户自己昵称
    ModifyTypeLock //修改锁名称
};

@class HDZKLockModel;
@interface YZBLNickNameViewController : HDZKBaseViewController

@property (nonatomic,copy)NSString *nickName;

@property (nonatomic,strong) HDZKLockModel *lockModel;

@property (copy,nonatomic) void(^gainNickName)(NSString *nick_name);


- (instancetype)initWithType:(ModifyType)type;


@end
