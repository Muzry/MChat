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
        textView.titleLabel.font = [UIFont systemFontOfSize:15];
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

    if (model.type == MessageModelMe)
    {
        self.icon.image = [UIImage imageNamed:@"Gatsby"];
    }
    else
    {
        self.icon.image = [UIImage imageNamed:@"Jobs"];
    }
    [[self.icon layer] setBorderWidth:0.5];
    [[self.icon layer] setBorderColor:SelfColor(218, 218, 218).CGColor];
    
    // 3.正文
    self.textView.frame = frameMessage.textViewF;
    [self.textView setTitle:model.text forState:UIControlStateNormal];
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

@end
