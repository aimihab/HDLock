//
//  HDZKAuthorKeyModel.h
//  HDZKLockApp
//
//  Created by lq on 2017/12/11.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDZKAuthorKeyModel : NSObject


/**
 钥匙ID
 */
@property (nonatomic , copy) NSString *key_id;


/**
 钥匙的Mac地址
 */
@property (nonatomic , copy) NSString *key_mac;


/**
 钥匙名称
 */
@property (nonatomic , copy) NSString *key_name;


/**
 钥匙所属锁ID
 */
@property (nonatomic , copy) NSString *bind_id;


/**
 授权时间
 */
@property (nonatomic , assign) NSInteger created_at;

/**
 授权记录ID
 */
@property (nonatomic , assign) NSInteger id;





@end
