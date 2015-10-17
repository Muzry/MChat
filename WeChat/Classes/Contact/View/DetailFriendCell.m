//
//  DetailFriendCell.m
//  WeChat
//
//  Created by LiDan on 15/10/16.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "DetailFriendCell.h"
#import "XMPPvCardTemp.h"

@interface DetailFriendCell()

@property (nonatomic,weak) UILabel *nickName;
@property (nonatomic,weak) UILabel *userAccount;
@property (nonatomic,weak) UIButton *avatar;
@property (nonatomic,weak) UIImageView *sex;

@end

@implementation DetailFriendCell
- (instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

-(void)setInit
{
    XMPPvCardTemp *vCard = nil;
    
    UIButton *avatar = [[UIButton alloc]init];
    [avatar setImage:[UIImage imageNamed:@"DefaultProfileHead_phone"] forState:UIControlStateNormal];
    [[avatar layer] setBorderColor:SelfColor(206, 206, 206).CGColor];
    [[avatar layer] setBorderWidth:1.0];
    [[avatar layer] setCornerRadius:5];
    [[avatar layer] setMasksToBounds:YES];
    [avatar addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *nickName = [[UILabel alloc]init];
    nickName.text = self.Jid.user;
    nickName.font = [UIFont systemFontOfSize:17];
    
    UILabel *userAccount = [[UILabel alloc]init];
    NSString *account =[NSString stringWithFormat:@"微信号: %@",self.Jid.user];
    userAccount.text = account;
    userAccount.textColor = SelfColor(149, 149, 149);
    userAccount.font = [UIFont systemFontOfSize:14];
    
    UIImageView *sex = [[UIImageView alloc]init];
    [sex setImage:[UIImage imageNamed:@"Contact_Male"]];
    
    vCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:self.Jid shouldFetch:YES];
    if (vCard)
    {
        if (vCard.nickname)
        {
            nickName.text = vCard.nickname;
        }
        if (vCard.photo)
        {
            [avatar setImage:[UIImage imageWithData:vCard.photo]  forState:UIControlStateNormal];
        }
        if ([vCard.role isEqualToString:@"女"])
        {
            [sex setImage:[UIImage imageNamed:@"Contact_Female"]];
        }
    }
    
    self.avatar = avatar;
    self.nickName = nickName;
    self.userAccount = userAccount;
    self.sex = sex;
    [self addSubview:avatar];
    [self addSubview:nickName];
    [self addSubview:userAccount];
    [self addSubview:sex];

}

-(void)btnClick:(UIButton *)btn
{
    [UIImage showImage:btn.imageView];
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
    
    
    self.userAccount.width = [self setContorllerWidth:self.userAccount.font andText:self.userAccount.text];
    self.userAccount.height = 30;
    self.userAccount.x = self.nickName.x;
    self.userAccount.y = self.avatar.height* 0.6;
    
    self.sex.width = 20;
    self.sex.height = self.sex.width;
    self.sex.x = self.nickName.width + self.nickName.x + 10;
    self.sex.y = self.nickName.y + 5;
}


-(CGFloat)setContorllerWidth:(UIFont *)font andText:(NSString *)text
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.width;
}

@end
