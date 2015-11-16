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
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *date = msg.timestamp;
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
    NSDateComponents *compsnow = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:now];
    
    NSInteger diffday = compsnow.day - comps.day;

    if ([[fmt stringFromDate:date] isEqualToString:[fmt stringFromDate:now]])
    {
        fmt.dateFormat = @"HH:mm";
        msgmodel.time = [fmt stringFromDate:date];
    }
    else if(diffday == 1)
    {
        fmt.dateFormat = @"昨天 HH:mm";
        msgmodel.time = [fmt stringFromDate:date];
    }
    else if(diffday >= 2 && diffday <= 7)
    {
        NSArray *weekday = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
        
        fmt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",weekday[compsnow.weekday + 6 - diffday]];
        msgmodel.time = [fmt stringFromDate:date];
    }
    else
    {
        fmt.dateFormat = @"yyyy年MM月dd日";
        msgmodel.time = [fmt stringFromDate:date];
    }

    return msgmodel;
}

@end
