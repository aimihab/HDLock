//
//  HDZKEmptyTableViewController.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/19.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "YZBLTableViewController.h"


typedef NS_ENUM(NSInteger,HDZKEmptyType) {
    HDZKEmptyTypeOpenRecords = 1, //开锁记录
    HDZKEmptyTypeNoticeList, //消息通知
    HDZKEmptyTypeBridalParty, //亲友团
    HDZKEmptyTypeKeychain, //我的钥匙串
    
};

@interface HDZKEmptyTableViewController : YZBLTableViewController
@property (nonatomic,assign) HDZKEmptyType type;

@end
