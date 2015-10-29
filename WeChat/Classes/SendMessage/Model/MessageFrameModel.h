//
//  QQMessageFrameModel.h
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MessageModel;

@interface MessageFrameModel : NSObject


/**时间的frame*/
@property (nonatomic,assign,readonly) CGRect timeF;

/**正文的frame*/
@property (nonatomic,assign,readonly) CGRect textViewF;

/**图像的frame*/
@property (nonatomic,assign,readonly) CGRect iconF;

/**cell的高度*/
@property (nonatomic,assign,readonly) CGFloat cellH;

/**数据模型*/
@property (nonatomic,strong) MessageModel *message;

@end
