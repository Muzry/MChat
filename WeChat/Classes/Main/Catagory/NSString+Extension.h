//
//  NSString+Extension.h
//  蛋蛋微博
//
//  Created by LiDan on 15/8/27.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)
- (CGSize)sizeWithLabelFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithLabelFont:(UIFont *)font;
@end
