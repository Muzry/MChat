//
//  UITextField+WF.m
//  WeiXin
//
//  Created by Yong Feng Guo on 14-11-21.
//  Copyright (c) 2014年 Fung. All rights reserved.
//

#import "UITextField+WF.h"

@implementation UITextField (WF)
-(void)addLeftViewWithImage:(NSString *)image{
   
    
    // 密码输入框左边图片
    UIImageView *lockIv = [[UIImageView alloc] init];
    
    // 设置尺寸
    CGRect imageBound = self.bounds;
    // 宽度高度一样
    imageBound.size.width = imageBound.size.height;
    lockIv.bounds = imageBound;
    
    // 设置图片
    lockIv.image = [UIImage imageNamed:image];
    
    // 设置图片居中显示
    lockIv.contentMode = UIViewContentModeCenter;
    
    // 添加TextFiled的左边视图
    self.leftView = lockIv;
    
    // 设置TextField左边的总是显示
    self.leftViewMode = UITextFieldViewModeAlways;
}


-(BOOL)isTelphoneNum{
    
    NSString *telRegex = @"^1[3578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:self.text];
}
@end
