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


-(void)setupKeyBoard
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)keyboardDidChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    double keyDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyBoardRect = [userInfo [UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:keyDuration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, keyBoardRect.origin.y - dScreenHeight);
    }];
}


-(void)setup
{
    self.title = self.nickName;
    CGRect size = [UIScreen mainScreen].bounds;
    CGFloat width = size.size.width;
    CGFloat height = size.size.height;
    
    MessageTableView *tableView = [[MessageTableView alloc]init];
    tableView.Jid = self.Jid;
    tableView.x = tableView.y = 0;
    tableView.width = width;
    tableView.height = height - 64 - 42;
    
    MessageToolsView *toolsView = [[MessageToolsView alloc]init];
    toolsView.Jid = self.Jid;
    toolsView.x = 0;
    toolsView.y = tableView.height;
    toolsView.height = 42;
    toolsView.width = width;
    toolsView.hidden = NO;
    
//    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:10 inSection:0];
//    [tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.view addSubview:tableView];
    [self.view addSubview:toolsView];
}

@end
