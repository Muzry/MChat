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
@end
