//
//  UIImage+YZBL.h
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (YZBL)
/*
 * Create image from color.
 * 从颜色创建图片
 * @color: The color of the image.
 * @color: 图片的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/*
 * The image trimming to the specified dimensions
 * 将图片修剪为指定尺寸
 * @img: original image
 * @img: 原始图片
 * @size: destinated size
 * @size: 目标size
 * @complete: complete invoke
 * @complete: 完成回调
 */
+ (void)imageCutImage:(UIImage *)img toSize:(CGSize)size complete:(void(^)(UIImage *result))complete;

/**
 图片压缩
 
 @param image 原图
 @return 压缩图数据
 */
+ (NSData *)compressImage:(UIImage *)image;

- (UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize;



@end
