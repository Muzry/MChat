//
//  MeMainCell.m
//  WeChat
//
//  Created by LiDan on 15/10/10.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MeMainCell.h"
#import "UserInfo.h"

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
        [avatar setImage:[UIImage imageNamed:@"DefaultHead"]];
        self.avatar = avatar;
        
        UILabel *nickName = [[UILabel alloc]init];
        nickName.text = @"Muzry";
        nickName.font = [UIFont systemFontOfSize:20];
        self.nickName = nickName;
        
        UILabel *account = [[UILabel alloc]init];
        NSString *accountName = [NSString stringWithFormat:@"微信号:%@",[UserInfo sharedUserInfo].user];
        account.text = accountName;
        account.font = [UIFont systemFontOfSize:16];
        self.account = account;
        
        [self addSubview:avatar];
        [self addSubview:nickName];
        [self addSubview:account];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    self.avatar.width = 70;
    self.avatar.height = 70;
    self.avatar.x = 10;
    self.avatar.y = 10;
    
    self.nickName.width = 150;
    self.nickName.height = 30;
    self.nickName.x = self.avatar.width + CellBoard + self.avatar.x;
    self.nickName.y = self.avatar.height* 0.2;
    
    self.account.width = 150;
    self.account.height = 30;
    self.account.x = self.nickName.x;
    self.account.y = self.avatar.height* 0.6;
}
@end
