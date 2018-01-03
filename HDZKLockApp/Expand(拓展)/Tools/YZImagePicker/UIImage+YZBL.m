//
//  UIImage+YZBL.m
//  BLChat
//
//  Created by baoyx on 2017/6/12.
//
//

#import "UIImage+YZBL.h"

@implementation UIImage (YZBL)
/*
 * Create image from color.
 * 从颜色创建图片
 * @color: The color of the image.
 * @color: 图片的颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    UIGraphicsBeginImageContext(CGSizeMake(10, 10));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, 10, 10));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
 * The image trimming to the specified dimensions
 * 将图片修剪为指定尺寸
 * @img: original image
 * @img: 原始图片
 * @size: destinated size unit：pixel
 * @size: 目标size 单位：像素
 * @complete: complete invoke
 * @complete: 完成回调
 */
+ (void)imageCutImage:(UIImage *)img toSize:(CGSize)size complete:(void(^)(UIImage *result))complete {
    //    aktDispatcher_global_add(^(AKTAsyncTaskInfo *taskInfo) {
    //        [taskInfo setTaskOperation:^id{
    //            return nil;
    //        }];
    //    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *newImage;
        CGSize imgSize = img.size;
        CGPoint drawPoint;
        CGSize scaledSize;
        if (imgSize.width/imgSize.height < size.width/size.height) {//scale with width
            scaledSize = CGSizeMake(size.width, imgSize.height/(imgSize.width/size.width));
            drawPoint.x = 0;
            drawPoint.y = - (scaledSize.height-size.height)/2;
        }else{//scale with height
            scaledSize = CGSizeMake(imgSize.width/(imgSize.height/size.height), size.height);
            drawPoint.y = 0;
            drawPoint.x = - (scaledSize.width-size.width)/2;
        }
        UIGraphicsBeginImageContext(size);
        [img drawInRect:CGRectMake(drawPoint.x, drawPoint.y, scaledSize.width, scaledSize.height)];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(newImage);
            }
        });
    });
}


+ (NSData *)compressImage:(UIImage *)image{
    // Compress by quality
    CGFloat compression = 1;
    NSInteger maxLength = 200*1024 ;// 200Kb
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    return data;
}

-(UIImage *)imageWithTitle:(NSString *)title fontSize:(CGFloat)fontSize
{
    //画布大小
    
    CGSize size=CGSizeMake(self.size.width,self.size.height);
    
    //创建一个基于位图的上下文
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);//opaque:NO  scale:0.0
    
    
    [self drawAtPoint:CGPointMake(0.0,0.0)];
    
    
    
    //文字居中显示在画布上
    
    NSMutableParagraphStyle* paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paragraphStyle.alignment=NSTextAlignmentCenter;//文字居中
    
    
    
    //计算文字所占的size,文字居中显示在画布上
    
    CGSize sizeText=[title boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin
                     
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor whiteColor]}context:nil].size;
    
    CGFloat width = self.size.width;
    
    CGFloat height = self.size.height;
    
    
    
    CGRect rect = CGRectMake((width-sizeText.width)/2, (height-sizeText.height)/2, sizeText.width, sizeText.height);
    
    //绘制文字
    
    [title drawInRect:rect withAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:fontSize],NSForegroundColorAttributeName:[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle}];
    
    //返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
