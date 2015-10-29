//
//  QQMessageModel.h
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    MessageModelMe = 0, // 自己
    MessageModelOther = 1 //别人
}MessageModelType;

@interface MessageModel : NSObject
/** 内容正文*/
@property (nonatomic,copy)NSString *text;
/** 文本时间*/
@property (nonatomic,copy)NSString *time;
/** 发送者*/
@property (nonatomic,assign)MessageModelType type;

@property (nonatomic,assign)BOOL isSameTime;

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)messageWithDict:(NSDictionary *)dict;

@end
