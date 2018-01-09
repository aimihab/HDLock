//
//  HDZKUserData.m
//  HDZKLockApp
//
//  Created by lq on 2017/12/8.
//  Copyright © 2017年 yzkj-lq. All rights reserved.
//

#import "HDZKUserData.h"
#import "HDZKLockModel.h"
#import "HDZKBeAuthorLockModel.h"
#import "HDZKLogModel.h"

#import <YYCache.h>

@interface HDZKUserData()

@end


@implementation HDZKUserData
SingletonM

-(instancetype)init
{
    if (self = [super init]) {
        
        self.bandLockList = (NSArray *) [UserLockDataCache objectForKey:BindLockListKey];
        self.authoredLockList = (NSArray *) [UserLockDataCache objectForKey:AuthorLockListKey];
        
    }
    return self;
}

#pragma mark - getter
/*
- (NSArray *)bandLockList{
    
    NSArray *value = (NSArray *) [UserLockDataCache objectForKey:BindLockListKey];
    
    return value;
}

- (NSArray *)authoredLockList{
    
    NSArray *value = (NSArray *) [UserLockDataCache objectForKey:AuthorLockListKey];
    
    return value;
}
*/


- (HDZKLockModel *)currentLockModel{
    
    if (_currentLockModel == nil) {
        
        _currentLockModel = [[HDZKLockModel alloc] init];
        
        if ([UserLockDataCache containsObjectForKey:CurrentLockModelKey]) {
            _currentLockModel = (HDZKLockModel *)[UserLockDataCache objectForKey:CurrentLockModelKey];
        }
    }
    
    return _currentLockModel;
}


- (NSArray *)lockPeripheralNames{
    
    NSMutableArray *names = [NSMutableArray array];
    
    [self.bandLockList enumerateObjectsUsingBlock:^(HDZKLockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [names addObject:obj.dev_name];
    }];
    [self.authoredLockList enumerateObjectsUsingBlock:^(HDZKLockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [names addObject:obj.dev_name];
    }];
    
    return [names copy];
}



#pragma mark  - Public

- (void)updateBandLockListCacheWith:(NSArray*)list{
    
    /*
    YYCache *cache = [YYCache cacheWithName:@"UserDataCache"];
    NSString *key = [NSString stringWithFormat:@"%@_bandLockList",YZUserModelInstance.u_id];
    */
    NSMutableArray *bandList = [NSMutableArray array];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        HDZKLockModel *model = [HDZKLockModel yy_modelWithJSON:obj];
        [bandList addObject:model];
    }];
    
    self.bandLockList = [NSArray arrayWithArray:bandList];
    [UserLockDataCache setObject:bandList forKey:BindLockListKey withBlock:^{
        DLog(@"缓存成功..");
    }];
    
}

- (void)updateAuthoredLockListCacheWith:(NSArray <HDZKBeAuthorLockModel*>*)list{
    /*
    YYCache *cache = [YYCache cacheWithName:@"UserDataCache"];
    NSString *key = [NSString stringWithFormat:@"%@_authorLockList",YZUserModelInstance.u_id];
    */
    self.authoredLockList = list;
    [UserLockDataCache setObject:list forKey:AuthorLockListKey withBlock:^{
        DLog(@"缓存成功..");
    }];
}

- (void)updateLogListCacheWith:(HDZKLogModel *)model{
    
    
    
}


+ (BOOL)haveBindorAuthoredLock{
    
    HDZKUserData *userData = [[self alloc] init];
    if (userData.bandLockList.count>0 || userData.authoredLockList.count>0 ) {
        
        return YES;
    }
    
    return NO;
}


@end
