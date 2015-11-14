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

typedef enum
{
    MessageTypeText = 0,  // 文本
    MessageTypeImage = 1, // 图片
    MessageTypeAudio = 2  // 音频
}MessageType; // 收到消息的类型

@interface MessageModel : NSObject
/** 内容正文*/
@property (nonatomic,copy)NSString *text;
/** 文本时间*/
@property (nonatomic,copy)NSString *time;
/** 发送者*/
@property (nonatomic,assign)MessageModelType type;

@property (nonatomic,assign)MessageType messageType;

@property (nonatomic,assign)BOOL isSameTime;

+(MessageModel*)initWithFetchObject:(XMPPMessageArchiving_Message_CoreDataObject *)msg;

@end
