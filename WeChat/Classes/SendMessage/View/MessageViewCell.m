//
//  QQMessageViewCell.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageViewCell.h"
#import "MessageFrameModel.h"
#import "MessageModel.h"
#import "UIImage+ResizeImage.h"
#import "XMPPvCardTemp.h"
#import "UIButton+WebCache.h"

@interface MessageViewCell()

/**显示时间*/
@property (nonatomic,weak)UILabel *time;

/**显示正文*/
@property (nonatomic,weak)UIButton *textView;

/**显示图片*/
@property (nonatomic,weak)UIImageView *icon;

@end

@implementation MessageViewCell

+(instancetype)messageCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"messageCell";
    
    MessageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if  (cell == nil)
    {
        cell =[[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = [UIColor clearColor];

        //1.时间Label
        UILabel *time = [[UILabel alloc]init];
        time.textAlignment = NSTextAlignmentCenter;
        time.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:time];
        self.time = time;
        
        //2.正文
        UIButton *textView = [[UIButton alloc]init];
        textView.titleLabel.font = [UIFont systemFontOfSize:16];
        textView.titleLabel.tintColor = [UIColor blackColor];
        textView.titleLabel.numberOfLines = 0;
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        textView.contentEdgeInsets = UIEdgeInsetsMake(5, 12, 12, 12);
        [self.contentView addSubview:textView];
        self.textView = textView;
        
        //3.头像
        UIImageView *icon = [[UIImageView alloc] init];

        [self.contentView addSubview:icon];
        self.icon = icon;

    }
    return self;
}

-(void)setFrameMessage:(MessageFrameModel *)frameMessage
{
    _frameMessage = frameMessage;
    MessageModel *model = frameMessage.message;
    
    if (model.isSameTime == NO)
    {
        // 1.时间
        self.time.frame = frameMessage.timeF;
        self.time.text = model.time;
        self.time.hidden = NO;
    }
    else
    {
        self.time.hidden = YES;
    }
    self.time.textColor = [UIColor grayColor];

    
    // 2.头像
    self.icon.frame = frameMessage.iconF;

    XMPPvCardTemp *VCard;
    if (model.type == MessageModelMe)
    {
        VCard = [XmppTools sharedXmppTools].vCard.myvCardTemp;
    }
    else
    {
        VCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:self.OtherJid shouldFetch:YES];
    }
    self.icon.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
    if (VCard.photo)
    {
        self.icon.image = [UIImage imageWithData:VCard.photo];
    }
    
    [[self.icon layer] setBorderWidth:0.5];
    [[self.icon layer] setBorderColor:SelfColor(218, 218, 218).CGColor];
    
    
    // 3.正文
    self.textView.frame = frameMessage.textViewF;

    if (model.messageType == MessageTypeText)
    {
        [self.textView setTitle:model.text forState:UIControlStateNormal];
        [self.textView setImage:nil forState:UIControlStateNormal];
    }
    else if (model.messageType == MessageTypeImage)
    {
        [self.textView sd_setImageWithURL:[NSURL URLWithString:model.text] forState:UIControlStateNormal];
        [self.textView addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.textView setTitle:nil forState:UIControlStateNormal];
    }
    if (model.type == MessageModelMe)
    {
        [self.textView setBackgroundImage:[UIImage resizeImageWihtImageName:@"SenderTextNodeBkg"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizeImageWihtImageName:@"SenderTextNodeBkgHL"] forState:UIControlStateHighlighted];
    }
    else
    {
        [self.textView setBackgroundImage:[UIImage resizeImageWihtImageName:@"ReceiverTextNodeBkg"] forState:UIControlStateNormal];
        [self.textView setBackgroundImage:[UIImage resizeImageWihtImageName:@"ReceiverTextNodeBkgHL"] forState:UIControlStateHighlighted];
    }
}

-(void)imageClick:(UIButton*)btn
{
    if (btn.imageView)
    {
        [UIImage showImage:btn.imageView];
    }
}

@end
