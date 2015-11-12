//
//  MeMainCell.m
//  WeChat
//
//  Created by LiDan on 15/10/10.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MeMainCell.h"
#import "UserInfo.h"
#import "XMPPvCardTemp.h"

@interface MeMainCell()

@property (nonatomic,weak) UIImageView * avatar;
@property (nonatomic,weak) UILabel *nickName;
@property (nonatomic,weak) UILabel *account;

@end

@implementation MeMainCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *avatar = [[UIImageView alloc]init];
        [[avatar layer] setCornerRadius:5];
        [[avatar layer] setMasksToBounds:YES];
        self.avatar = avatar;
        XMPPvCardTemp *myVCard = [XmppTools sharedXmppTools].vCard.myvCardTemp;
        
        if (myVCard.photo)
        {
            [avatar setImage:[UIImage imageWithData:myVCard.photo]];
        }
        else
        {
            [avatar setImage:[UIImage imageNamed:@"DefaultProfileHead_phone"]];
        }

        
        UILabel *nickName = [[UILabel alloc]init];
        nickName.text = [UserInfo sharedUserInfo].user;
        if (myVCard.nickname) {
            nickName.text = myVCard.nickname;
        }
        
        nickName.font = [UIFont systemFontOfSize:17];
        self.nickName = nickName;
        
        UILabel *account = [[UILabel alloc]init];
        NSString *accountName = [NSString stringWithFormat:@"微信号 : %@",[UserInfo sharedUserInfo].user];
        account.text = accountName;
        account.font = [UIFont systemFontOfSize:14];
        self.account = account;
        
        [self.contentView addSubview:avatar];
        [self.contentView addSubview:nickName];
        [self.contentView addSubview:account];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatar.width = 70;
    self.avatar.height = 70;
    self.avatar.x = 10;
    self.avatar.y = 10;
    
    self.nickName.width = [self setContorllerWidth:self.nickName.font andText:self.nickName.text];
    self.nickName.height = 30;
    self.nickName.x = self.avatar.width + CellBoard + self.avatar.x;
    self.nickName.y = self.avatar.height* 0.2;
    
    self.account.width = [self setContorllerWidth:self.account.font andText:self.account.text];
    self.account.height = 30;
    self.account.x = self.nickName.x;
    self.account.y = self.avatar.height* 0.6;
}


-(CGFloat)setContorllerWidth:(UIFont *)font andText:(NSString *)text
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}
@end
