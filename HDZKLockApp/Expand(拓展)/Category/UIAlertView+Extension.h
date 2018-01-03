//
//  UIAlertView+Extension.h
//  BLChat
//
//  Created by nacker on 16/7/23.
//  Copyright © 2017年 lq-yzkj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)();

@interface UIAlertView (Extension) <UIAlertViewDelegate>

+ (UIAlertView *)showAlertViewWithTitle:(NSString*) title
                                message:(NSString*) message
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed
                               onCancel:(CancelBlock) cancelled;
@end
