//
//  NewFriendCell.m
//  WeChat
//
//  Created by LiDan on 15/10/15.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "NewFriendCell.h"

@interface NewFriendCell()

@property (nonatomic,weak) UIButton *acceptButton;
@property (nonatomic,weak) UIButton *rejectButton;
@end

@implementation NewFriendCell

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton *acceptBtn = [[UIButton alloc]init];
        [acceptBtn addTarget:self action:@selector(acceptClick) forControlEvents:UIControlEventTouchUpInside];
        [acceptBtn setTitle:@"接受" forState:UIControlStateNormal];
        acceptBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [acceptBtn setTintColor:[UIColor whiteColor]];
        [acceptBtn setBackgroundImage:[UIImage resizeImageWihtImageName:@"fts_green_btn"] forState:UIControlStateNormal];
        self.acceptButton = acceptBtn;

        
        UIButton *rejectBtn = [[UIButton alloc]init];
        [rejectBtn addTarget:self action:@selector(rejectClick) forControlEvents:UIControlEventTouchUpInside];
        [rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [rejectBtn setTintColor:[UIColor whiteColor]];
        rejectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rejectBtn setBackgroundImage:[UIImage resizeImageWihtImageName:@"fts_gray_btn_HL"] forState:UIControlStateNormal];
        self.rejectButton = rejectBtn;
        
        UILabel *friendName = [[UILabel alloc]init];
        self.friendName = friendName;
        
        UIImageView *avatar = [[UIImageView alloc]init];
        self.avatar = avatar;
        
        XMPPJID *Jid = [[XMPPJID alloc] init];
        self.Jid = Jid;
        
        [self addSubview:avatar];
        [self addSubview:acceptBtn];
        [self addSubview:rejectBtn];
        [self addSubview:friendName];
    }
    return self;
}

-(void)acceptClick
{
    [[XmppTools sharedXmppTools].roster acceptPresenceSubscriptionRequestFrom:self.Jid andAddToRoster:YES];
    [[UserInfo sharedUserInfo].addFriends removeObject:self.Jid];
}

-(void)rejectClick
{
    [[XmppTools sharedXmppTools].roster rejectPresenceSubscriptionRequestFrom:self.Jid];
    [[UserInfo sharedUserInfo].addFriends removeObject:self.Jid];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.avatar.width = 40;
    self.avatar.height = 40;
    self.avatar.x = 10;
    self.avatar.y = 10;
    
    self.friendName.width = 200;
    self.friendName.height = 30;
    self.friendName.x = self.avatar.height + self.avatar.x + 10;
    self.friendName.y = 15;
    
    self.rejectButton.width = 50;
    self.rejectButton.height = 35;
    self.rejectButton.x = ScreenWidth - 10 - self.rejectButton.width;
    self.rejectButton.y = 12;
    
    self.acceptButton.width = 50;
    self.acceptButton.height = 35;
    self.acceptButton.x = self.rejectButton.x - 10 - self.acceptButton.width;
    self.acceptButton.y = 12;
}

@end
