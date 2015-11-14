//
//  QQMessageModel.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel

+(MessageModel*)initWithFetchObject:(XMPPMessageArchiving_Message_CoreDataObject *)msg
{
    MessageModel *msgmodel = [[MessageModel alloc]init];
    
    NSString * bodyType = [msg.message attributeStringValueForName:@"bodyType"];
    
    msgmodel.text = msg.body;
    
    if ([bodyType isEqualToString:@"text"])
    {
        msgmodel.messageType = MessageTypeText;
    }
    else if([bodyType isEqualToString:@"image"])
    {
        msgmodel.messageType = MessageTypeImage;
    }
    else
    {
        msgmodel.messageType = MessageTypeAudio;
    }
    
    
    if (msg.isOutgoing == YES)
    {
        msgmodel.type = MessageModelMe;
    }
    else
    {
        msgmodel.type = MessageModelOther;
    }
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"yyyy-MM-dd-HH:mm";
    NSDate *date = msg.timestamp;
    msgmodel.time = [fmt stringFromDate:date];
    
    return msgmodel;
}

@end
