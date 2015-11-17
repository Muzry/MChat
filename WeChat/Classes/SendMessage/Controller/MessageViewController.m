//
//  QQViewController.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageToolsView.h"
#import "UIView+Extension.h"
#import "MessageModel.h"
#import "MessageViewCell.h"
#import "MessageTableView.h"
#import "MessageFrameModel.h"
#import "Constant.h"

@interface MessageViewController()

@end

@implementation MessageViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setupKeyBoard];
    [self setup];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -- 加载XMPPMessageArchiving数据库的数据显示在表格


-(void)setupKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect keyBoardRect = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.y = keyBoardRect.origin.y - self.view.height;
    }];
}

-(void)setup
{
    self.title = self.nickName;
    CGRect size = [UIScreen mainScreen].bounds;
    CGFloat width = size.size.width;
    CGFloat height = size.size.height;
    
    MessageTableView *tableView = [[MessageTableView alloc]init];
    tableView.x = tableView.y = 0;
    tableView.width = width;
    tableView.height = height - 64 - 42;
    tableView.Jid = self.Jid;
    
    MessageToolsView *toolsView = [[MessageToolsView alloc]initWithFrame:CGRectMake(0, tableView.height, width, 42)];
    toolsView.Jid = self.Jid;
    toolsView.hidden = NO;
    
    [self.view addSubview:tableView];
    [self.view addSubview:toolsView];
    
    if (tableView.resultController.fetchedObjects.count > 0)
    {
        NSIndexPath *path = [NSIndexPath indexPathForItem:tableView.resultController.fetchedObjects.count - 1 inSection:0];
        [tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

@end
