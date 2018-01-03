//
//  YZBLImagePicker.m
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import "YZBLImagePicker.h"
#import "UIImage+YZBL.h"

@interface  YZBLImagePicker()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *vc;
@end
@implementation YZBLImagePicker
#pragma mark - life cycle
//|---------------------------------------------------------
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
#pragma mark - view settings
//|---------------------------------------------------------
- (void)chooseFromLibrary {
    [self.vc setSourceType:(UIImagePickerControllerSourceTypePhotoLibrary)];
    self.vc.allowsEditing = self.enableEditing;
    if(self.superVc) [self.superVc presentViewController:self.vc animated:YES completion:nil];
}
- (void)chooseFromPicture {
    [self.vc setSourceType:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)];
    self.vc.allowsEditing = self.enableEditing;
    if(self.superVc) [self.superVc presentViewController:self.vc animated:YES completion:nil];
}
- (void)chooseFromCamera {
    [self.vc setSourceType:(UIImagePickerControllerSourceTypeCamera)];
    [self.vc setCameraFlashMode:UIImagePickerControllerCameraFlashModeOff];
    self.vc.allowsEditing = self.enableEditing;
    if(self.superVc) [self.superVc presentViewController:self.vc animated:YES completion:nil];
}
#pragma mark - model settings
//|---------------------------------------------------------
- (void)initialize {
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    self.vc = ipc;
    ipc.delegate = self;
    self.size = CGSizeMake(FLT_MAX, FLT_MAX);
}
#pragma mark - delegate
//|---------------------------------------------------------
/*
 * Finish choosing a image.
 * 图片选择完成
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //    mAKT_Log(@"%@",info);
    if (self.result) {
        UIImage *img = self.enableEditing? info[UIImagePickerControllerEditedImage]:info[UIImagePickerControllerOriginalImage];
        if (self.size.width<FLT_MAX) {
            [UIImage imageCutImage:img toSize:(self.size) complete:^(UIImage *result) {
                self.result(NO, result);
                [picker dismissViewControllerAnimated:YES completion:nil];
            }];
            return;
        }
        self.result(NO, img);
    }
}
/*
 * Cancel choose image.
 * 取消图片选择
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    if (self.result) {
        self.result(YES, nil);
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
