//
//  UIImage+ResizeImage.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "UIImage+ResizeImage.h"

@implementation UIImage (ResizeImage)

+(UIImage *)resizeImageWihtImageName:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    CGFloat width = normal.size.width * 0.5;
    CGFloat heigh = normal.size.height * 0.5;
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(heigh, width, heigh, width)];
}

- (UIImage *)scaleImageWithWidth:(CGFloat)width
{
    if (self.size.width <width || width <= 0) {
        return self;
    }
    CGFloat scale = self.size.width/width;
    CGFloat height = self.size.height/scale;
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // 开始上下文 目标大小是 这么大
    UIGraphicsBeginImageContext(rect.size);
    
    // 在指定区域内绘制图像
    [self drawInRect:rect];
    
    // 从上下文中获得绘制结果
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文返回结果
    UIGraphicsEndImageContext();
    return resultImage;
}
@end
