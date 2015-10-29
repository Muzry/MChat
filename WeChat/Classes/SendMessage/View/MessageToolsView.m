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

@interface MessageToolsView()<UITextFieldDelegate>

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
        [self setupBtn:@"chat_bottom_up_nor" hightImage:@"chat_bottom_up_press" tag:MessageToolsViewtypeMore];
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
    UITextField *textField = [[UITextField alloc]init];
    [textField setBackground:[UIImage resizeImageWihtImageName:@"SendTextViewBkg"]];
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:15];
    textField.returnKeyType = UIReturnKeySend;
    textField.delegate = self;
    textField.enablesReturnKeyAutomatically = YES; 
    [self addSubview:textField];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //添加模型数据
    [self addMessage:textField.text type:MessageModelMe];
    if ([self autoReplay:[textField.text lowercaseString]])
    {
        [self addMessage:[self autoReplay:textField.text] type:MessageModelOther];
    }
    
    textField.text = @"";
    

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
    UITextField *textField = self.subviews.lastObject;
    textField.x = btnW;
    textField.y = self.height / 2 - btnH / 2;
    textField.height = btnH;
    textField.width = textW;
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
