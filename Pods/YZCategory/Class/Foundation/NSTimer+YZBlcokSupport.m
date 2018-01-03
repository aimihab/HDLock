//
//  NSTimer+YZBlcokSupport.m
//  YZCategory
//
//  Created by baoyx on 2017/5/12.
//  Copyright © 2017年 baoyx. All rights reserved.
//

#import "NSTimer+YZBlcokSupport.h"

@implementation NSTimer (YZBlcokSupport)
+(NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)())block repeats:(BOOL)repeat
{
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(xq_blockInvoke:) userInfo:[block copy] repeats:repeat];
}


+(void)xq_blockInvoke:(NSTimer *)timer{
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}
@end
