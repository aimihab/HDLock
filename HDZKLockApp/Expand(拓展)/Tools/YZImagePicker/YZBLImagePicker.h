//
//  YZBLImagePicker.h
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import <Foundation/Foundation.h>

@interface YZBLImagePicker : NSObject
@property (strong, nonatomic) void(^result)(BOOL cancled, UIImage *img);
@property (assign, nonatomic) BOOL enableEditing;
@property (assign, nonatomic) CGSize size;
@property (strong, nonatomic) UIViewController *superVc;
- (void)chooseFromLibrary;
- (void)chooseFromPicture;
- (void)chooseFromCamera;
@end
