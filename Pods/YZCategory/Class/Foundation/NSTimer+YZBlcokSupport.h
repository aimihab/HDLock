//
//  NSTimer+YZBlcokSupport.h
//  YZCategory
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YZBlcokSupport)
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                     block:(void(^)())block
                                   repeats:(BOOL)repeat;
@end
