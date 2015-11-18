//
//  MessageCell.m
//  WeChat
//
//  Created by LiDan on 15/11/12.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "WeChatCell.h"
#import "XMPPvCardTemp.h"
#import "MessageModel.h"

@interface WeChatCell()
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UILabel *text;
@property (nonatomic,weak) UIImageView *avatar;
@property (nonatomic,weak) UILabel *nickName;
@end

@implementation WeChatCell

+(instancetype)weChatCellWithTableView:(UITableView *)tableView AndDict:(NSDictionary *)dict
{
    static NSString *ID = @"weChatCell";
    
    WeChatCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell =[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID AndDict:dict];
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier AndDict:(NSDictionary *)dict
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        //0.用户昵称
        
        UILabel *nickName = [[UILabel alloc]init];
        XMPPJID *Jid = [XMPPJID jidWithString:dict[@"username"]];
        
        XMPPvCardTemp *VCard;
        VCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:Jid shouldFetch:YES];
        
        nickName.text = Jid.user;
        
        if (VCard.nickname)
        {
            nickName.text = VCard.nickname;
        }
        
        self.nickName = nickName;
        
        //1.时间Label
        UILabel *time = [[UILabel alloc]init];
        time.font = [UIFont systemFontOfSize:14];
        time.textColor = SelfColor(185, 185, 185);
        time.text = dict[@"time"];
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        
        fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
        fmt.dateFormat = @"yyyy-MM-dd-HH:mm";
        NSDate *date = [fmt dateFromString:dict[@"time"]];
        fmt.dateFormat = @"yyyy-MM-dd";
        NSDate *now = [NSDate date];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
        NSDateComponents *compsnow = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:now];
        
        NSInteger diffday = compsnow.day - comps.day;
        
        if ([[fmt stringFromDate:date] isEqualToString:[fmt stringFromDate:now]])
        {
            fmt.dateFormat = @"HH:mm";
            time.text = [fmt stringFromDate:date];
        }
        else if(diffday == 1)
        {
            fmt.dateFormat = @"昨天 HH:mm";
            time.text = [fmt stringFromDate:date];
        }
        else if(diffday >= 2 && diffday <= 7)
        {
            NSArray *weekday = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
            
            fmt.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",weekday[compsnow.weekday + 6 - diffday]];
            time.text = [fmt stringFromDate:date];
        }
        else
        {
            fmt.dateFormat = @"yyyy年MM月dd日";
            time.text = [fmt stringFromDate:date];
        }
        
        [self.contentView addSubview:time];
        self.time = time;
        
        //2.正文
        UILabel *text = [[UILabel alloc]init];
        text.font = [UIFont systemFontOfSize:14];
        text.textColor = SelfColor(185, 185, 185);
        text.text = dict[@"msgtext"];

        if([dict[@"type"] isEqualToString:@"image"])
        {
            text.text = @"[图片]";
        }
        self.text = text;
        
        //3.头像
        UIImageView *avatar = [[UIImageView alloc] init];
        [[avatar layer] setBorderColor:[UIColor clearColor].CGColor];
        [[avatar layer] setCornerRadius:5];
        [[avatar layer] setMasksToBounds:YES];
        [avatar setImage:[UIImage imageNamed:@"DefaultProfileHead_phone"]];
        if (VCard.photo)
        {
            [avatar setImage:[UIImage imageWithData:VCard.photo]];
        }
        
        self.avatar = avatar;
        
        
        [self.contentView addSubview:text];
        [self.contentView addSubview:avatar];
        [self.contentView addSubview:nickName];
        [self.contentView addSubview:time];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置头像位置
    
    self.avatar.x = 10;
    self.avatar.y = 10;
    self.avatar.width = 50;
    self.avatar.height = 50;
    
    //设置昵称位置
    
    self.nickName.x = self.avatar.x + self.avatar.width + 10;
    self.nickName.y = self.avatar.y + 5;
    self.nickName.height = 20;
    self.nickName.width = [self setContorllerWidth:self.nickName.font andText:self.nickName.text];
    
    //设置时间位置

    self.time.width = [self setContorllerWidth:self.time.font andText:self.time.text];
    self.time.x = self.width - self.time.width - 10;
    self.time.y = self.nickName.y;
    self.time.height = 20;
    
    //设置文本位置
    
    self.text.x = self.nickName.x;
    self.text.y = self.nickName.y + self.nickName.height + 5;
    self.text.width = [self setContorllerWidth:self.text.font andText:self.text.text];
    self.text.height = 20;
}

-(CGFloat)setContorllerWidth:(UIFont *)font andText:(NSString *)text
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

@end
