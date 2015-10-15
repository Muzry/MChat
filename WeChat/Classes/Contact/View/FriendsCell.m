//
//  FriendsCell.m
//  WeChat
//
//  Created by LiDan on 15/10/15.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "FriendsCell.h"

@implementation FriendsCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        UILabel *friendName = [[UILabel alloc]init];
        self.friendName = friendName;
        
        UIImageView *avatar = [[UIImageView alloc]init];
        self.avatar = avatar;
        
        [self addSubview:friendName];
        [self addSubview:avatar];
    }
    return self;
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
    
}


@end
