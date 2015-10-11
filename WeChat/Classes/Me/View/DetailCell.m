//
//  DetailCell.m
//  WeChat
//
//  Created by LiDan on 15/10/11.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "DetailCell.h"
#import "XMPPvCardTemp.h"

@interface DetailCell()

@end

@implementation DetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *avatar = [[UIImageView alloc]init];
        [[avatar layer] setBorderColor:SelfColor(206, 206, 206).CGColor];
        [[avatar layer] setBorderWidth:1.0];
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
            [avatar setImage:[UIImage imageNamed:@"DefaultHead"]];
        }
        
        [self addSubview:avatar];
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

-(void)setAvatar:(UIImageView *)avatar
{
    _avatar = avatar;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.avatar.width = 70;
    self.avatar.height = 70;
    self.avatar.x = self.width - 40 - self.avatar.width;
    self.avatar.y = 9;
}

@end
