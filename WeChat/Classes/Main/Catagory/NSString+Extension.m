//
//  NSString+Extension.m
//  蛋蛋微博
//
//  Created by LiDan on 15/8/27.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
- (CGSize)sizeWithLabelFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
}

- (CGSize)sizeWithLabelFont:(UIFont *)font
{
    return [self sizeWithLabelFont:font maxW:MAXFLOAT];
}
@end
