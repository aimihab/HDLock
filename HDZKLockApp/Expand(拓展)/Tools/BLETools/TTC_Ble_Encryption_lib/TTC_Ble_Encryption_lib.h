//
//  TTC_Ble_Encryption_lib.h
//  TTC_Ble_Encryption_lib
//
//  Created by TTC on 2017/6/21.
//  Copyright © 2017年 TTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTC_Ble_Encryption_lib : NSObject

/**解密*/
+ (NSData *)decryption:(NSData *)data;

/**加密*/
+ (NSData *)encryption:(NSString *)string;

@end
