//
//  QQTableView.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageTableView.h"
#import "MessageModel.h"
#import "MessageViewCell.h"
#import "MessageFrameModel.h"

@interface MessageTableView() <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSMutableArray * message;
@end

@implementation MessageTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.delegate = self;
        self.dataSource = self;
        self.allowsSelection = NO;
        self.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addMessage:) name:@"addMessage" object:nil];

    }
    return self;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.superview endEditing:YES];
}

-(void)addMessageArray:(QQMessageFrameModel *)frameModel
{
    [self.message addObject:frameModel];
    [self reloadData];
}

-(NSMutableArray *)message
{
    if (!_message)
    {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil]];
        
        NSMutableArray *messageArr = [NSMutableArray array];
        
        for (NSDictionary *dict in array)
        {
            MessageModel *message = [MessageModel messageWithDict:dict];
            
            MessageFrameModel *frameModel = [[MessageFrameModel alloc]init];
            
            MessageFrameModel *lastModel = [messageArr lastObject];
            message.isSameTime =  [lastModel.message.time isEqualToString:message.time];
            
            frameModel.message = message;
            
            [messageArr addObject:frameModel];
        }
        _message = messageArr;
    }
    return _message;
}

-(void)addMessage:(NSNotification *)notification
{
    MessageFrameModel *frameModel = notification.userInfo[@"FrameModel"];
    MessageFrameModel *lastModel = [self.message lastObject];
    frameModel.message.isSameTime =[frameModel.message.time isEqual:lastModel.message.time];
    [self.message addObject:frameModel];
    [self reloadData];
    [self ScrollToEnd];
}

-(void)ScrollToEnd
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:self.message.count - 1 inSection:0];
    [self scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.message.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageViewCell *cell = [MessageViewCell messageCellWithTableView:tableView];
    QQMessageFrameModel *frameModel = self.message[indexPath.row];
    cell.frameMessage = frameModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFrameModel *frameModel = self.message[indexPath.row];
    return frameModel.cellH;
}

@end
