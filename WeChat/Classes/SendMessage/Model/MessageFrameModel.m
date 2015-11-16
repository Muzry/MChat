//
//  QQMessageFrameModel.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageFrameModel.h"
#import "Constant.h"
#import "MessageModel.h"
#import "UIButton+WebCache.h"

@implementation MessageFrameModel

-(void)setMessage:(MessageModel *)message
{
    _message = message;
    
    // 1.设置时间位置
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = dScreenWidth;
    CGFloat timeH = dNormalHeight;
    
    _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    // 2.设置头像位置
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF);
    CGFloat iconW = dIconW;
    CGFloat iconH = dIconH;
    
    
    // 3.设置正文位置
    
    CGFloat textX;
    CGFloat textY = iconY;
    
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    CGSize btnSize;
    CGSize textRealSize;
    if (message.messageType == MessageTypeText)
    {
         textRealSize = [message.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:dBtnFont} context:nil].size;
         btnSize = CGSizeMake(textRealSize.width + 36, textRealSize.height + 34);
    }
    else if (message.messageType == MessageTypeImage)
    {
        textRealSize = CGSizeMake(200, 150);
        btnSize = textRealSize;
    }

    
    if (message.type == MessageModelMe)
    {
        iconX = dScreenWidth - dIconPadding - dIconW;
        textX = dScreenWidth - dIconW - 2 * dIconPadding - btnSize.width;
    }
    else
    {
        iconX = dIconPadding;
        textX = dIconW + 2 * dIconPadding;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    _textViewF = (CGRect){{textX,textY},btnSize};
    // 4.cell高度
    
    CGFloat iconMaxH = CGRectGetMaxY(_iconF);
    CGFloat textMaxH = CGRectGetMaxY(_textViewF);
    _cellH = MAX(iconMaxH, textMaxH);
    
}

@end
