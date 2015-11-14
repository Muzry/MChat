//
//  UIImage+ResizeImage.h
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeImage)
+(UIImage *)resizeImageWihtImageName:(NSString *)name;
- (UIImage *)scaleImageWithWidth:(CGFloat)width;
@end
