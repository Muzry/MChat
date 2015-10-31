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

@property (nonatomic,strong)NSDictionary *autoReplay;

@end

@implementation MessageToolsView

-(NSDictionary *)autoReplay
{
    if (!_autoReplay) {
        _autoReplay = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoReplay.plist" ofType:nil]];
    }
    return _autoReplay;
}

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
    [self addSubview:msgView];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([@"\n" isEqualToString:text] == YES)
    {
        [self addMessage:textView.text type:MessageModelMe];
        if ([self autoReplay:[textView.text lowercaseString]])
        {
            [self addMessage:[self autoReplay:textView.text] type:MessageModelOther];
        }
        textView.text = @"";
        return NO;
    }
    return YES;
}


-(NSString *)autoReplay:(NSString *)text
{
    for (NSString* key in self.autoReplay)
    {
        if ([text rangeOfString:key].location < text.length)
        {
            return [self.autoReplay objectForKey:key];
        }
    }
    return @"[自动回复]您好，我有事不在，请留言";
}

-(void)addMessage:(NSString *)text type:(MessageModelType*)type
{
    MessageModel *model = [[MessageModel alloc]init];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    fmt.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"HH:mm";
    NSDate *date = [NSDate date];
    
    model.time = [fmt stringFromDate:date];
    model.text = text;
    model.type = type;
    
    MessageFrameModel *fm = [[MessageFrameModel alloc]init];
    fm.message = model;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"FrameModel"] = fm;
    
    NSNotification *notification =[NSNotification notificationWithName:@"addMessage" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
