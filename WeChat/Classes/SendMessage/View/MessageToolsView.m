//
//  QQToolsView.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageToolsView.h"
#import "UIView+Extension.h"
#import "MessageModel.h"
#import "MessageFrameModel.h"
#import "MessageTableView.h"

@interface MessageToolsView()<UITextViewDelegate>


@end
@implementation MessageToolsView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"chat_bottom_bg"]];
        
        [self setupBtn:@"ToolViewInputVoice" hightImage:@"ToolViewInputVoiceHL" tag:MessageToolsViewTypeSpeak];
        [self setupBtn:@"ToolViewEmotion" hightImage:@"ToolViewEmotionHL" tag:MessageToolsViewTypeEmotion];
        [self setupBtn:@"TypeSelectorBtn_Black" hightImage:@"TypeSelectorBtn_BlackHL" tag:MessageToolsViewtypeMore];
        [self setupText];
    }
    return self;
}

-(UIButton *)setupBtn:(NSString *)image hightImage:(NSString *)hightImage tag:(MessageToolsViewType)type;
{
    UIButton * btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed: image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed: hightImage] forState:UIControlStateHighlighted];
    [self addSubview:btn];
    btn.tag = type;
    return btn;
}

-(void)setupText
{
    UITextView *msgView = [[UITextView alloc]init];
    
    msgView.returnKeyType = UIReturnKeySend;
    msgView.delegate = self;
    msgView.enablesReturnKeyAutomatically = YES;
    msgView.backgroundColor = [UIColor clearColor];
    msgView.font = [UIFont systemFontOfSize:15];
    msgView.contentInset = UIEdgeInsetsMake(5, 8, 0, 0);
    msgView.scrollEnabled = NO;
    msgView.font = [UIFont systemFontOfSize:16];
    [self addSubview:msgView];
}

#pragma mark TextView的代理
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        
        NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
        
        fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
        fmt.dateFormat = @"yyyy-MM-dd-HH:mm";
        NSDate *date = [NSDate date];
        

        
        NSString *final = [textView.text substringWithRange:NSMakeRange(0, range.location)];
        [self sendMsgWithText:final Time:[fmt stringFromDate:date]];

        
        newDict[@"username"] = self.Jid.bare;
        newDict[@"msgtext"] = final;
        newDict[@"time"] = [fmt stringFromDate:date];
        
        textView.text = @"";
        
        int i = 0;
        BOOL flag = NO;
        for (NSDictionary *dict in [UserInfo sharedUserInfo].msgRecordArray)
        {
            if ([dict[@"username"] isEqualToString:newDict[@"username"]])
            {
                [UserInfo sharedUserInfo].msgRecordArray[i] = newDict;
                flag = YES;
                break;
            }
            i++;
        }
        if (!flag)
        {
            [[UserInfo sharedUserInfo].msgRecordArray addObject:newDict];
        }
        [self writeToFile];
        NSNotification *notification =[NSNotification notificationWithName:@"SendMessage" object:nil userInfo:newDict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    
    return YES;
}


-(void)writeToFile
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = [NSString stringWithFormat:@"records%@.plist",[UserInfo sharedUserInfo].user];
    [[UserInfo sharedUserInfo].msgRecordArray writeToFile:[[pathList objectAtIndex:0] stringByAppendingPathComponent:filename] atomically:YES];
}

-(void)sendMsgWithText:(NSString *)text Time:(NSString *)time
{
    XMPPMessage *msg = [XMPPMessage messageWithType:@"chat" to:self.Jid];
    
    [msg addBody:text];
    [msg addSubject:time];
    [[XmppTools sharedXmppTools].xmppStream sendElement:msg];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    CGFloat btnW = 42;
    CGFloat btnH = 42;
    CGFloat textW = self.width - 3 * btnW;
    
    UITextView *msgView = [self.subviews lastObject];
    msgView.x = btnW;
    msgView.y = self.height / 2 - btnH / 2;
    msgView.height = btnH - 2;
    msgView.width = textW;
    UIImageView *imgView = [[UIImageView alloc]initWithFrame: CGRectMake(-10, -4, msgView.width, msgView.height)];
    
    imgView.image = [UIImage resizeImageWihtImageName:@"SendTextViewBkg"];
    [msgView addSubview: imgView];
    [msgView sendSubviewToBack:imgView];
    
    for (int i = 0;  i < count - 1; i ++)
    {
        UIButton *button = self.subviews[i];
        button.x = i * btnW;
        if (i > 0)
        {
            button.x += textW;
        }
        button.y = self.height / 2 - btnH / 2;
        button.width = btnW;
        button.height = btnH;
    }
}

@end
