//
//  UIImage+Extension.m
//  WeChat
//
//  Created by LiDan on 15/10/12.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "UIImage+Extension.h"

static CGRect oldFrame;

@implementation UIImage (Extension)

+(void)showImage:(UIImageView *)imageView
{
    UIImage *image = imageView.image;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    oldFrame = [imageView convertRect:imageView.bounds toView:window];
    
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    UIImageView *newImageView = [[UIImageView alloc]initWithFrame:oldFrame];
    newImageView.image = image;
    [backgroundView addSubview:newImageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^
    {
        newImageView.frame = CGRectMake(0, (ScreenHeight - image.size.height * ScreenWidth / image.size.width)/2, ScreenWidth, image.size.height * ScreenWidth / image.size.width);
        backgroundView.alpha = 1;
    } completion:nil];
}

+(void)hideImage:(UITapGestureRecognizer*)tap
{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=[[UIImageView alloc]init];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=oldFrame;
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
