//
//  NSObject+LQCoding.h
//  HDZKLockApp
//
//  Created by lq on 2018/1/3.
//  Copyright © 2018年 yzkj-lq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LQCoding)


/**
 * 可以代替手写归档协议方法,支持
 * 继承类，对象嵌套以及字典、数组中持有对象
 *
 */
-(void)encodeWithCoder:(NSCoder *)aCoder;

-(id)initWithCoder:(NSCoder *)aDecoder;



/**
 * 用于从字典生成模型类对象
 *
 */
+(id)objectFromDic:(NSDictionary*)dic;


/**
 用于获取模型对象数组

 @param array 数据源数组
 @return 模型数组
 */
+(NSArray *)objectArrayFromArray:(NSArray *)array;



@end
