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

@interface MessageTableView() <UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_resultController;
}

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
        
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self loadMsgs];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.superview endEditing:YES];
}

#pragma mark -- 加载XMPPMessageArchiving数据库的数据显示在表格
-(void)loadMsgs
{
    // 上下文
    NSManagedObjectContext *context = [XmppTools sharedXmppTools].msgStorage.mainThreadManagedObjectContext;
    
    //请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPMessageArchiving_Message_CoreDataObject"];
    
    // 过滤，排序
    // 1、当前登录用户的JID
    // 2、好友的JID
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@ AND bareJidStr = %@",[UserInfo sharedUserInfo].JID,self.Jid.bare];
    
    // 时间升序
    NSSortDescriptor *timeSort = [NSSortDescriptor sortDescriptorWithKey:@"timestamp" ascending:YES];
    request.predicate = pre;
    request.sortDescriptors = @[timeSort];
    
    //查询
    _resultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    NSError *err = nil;
    _resultController.delegate = self;
    [_resultController performFetch:&err];
    if (err)
    {
        NSLog(@"%@",err);
    }

}


-(void)ScrollToEnd
{
    NSIndexPath *path = [NSIndexPath indexPathForItem:_resultController.fetchedObjects.count - 1 inSection:0];
    [self scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageViewCell *cell = [MessageViewCell messageCellWithTableView:tableView];
    
    XMPPMessageArchiving_Message_CoreDataObject *msg = _resultController.fetchedObjects[indexPath.row];
    MessageModel *message = [MessageModel initWithFetchObject:msg];
    
    MessageFrameModel *frameModel = [[MessageFrameModel alloc]init];
    frameModel.message = message;
    cell.frameMessage = frameModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XMPPMessageArchiving_Message_CoreDataObject *msg = _resultController.fetchedObjects[indexPath.row];
    MessageModel *message = [MessageModel initWithFetchObject:msg];
    
    MessageFrameModel *frameModel = [[MessageFrameModel alloc]init];
    frameModel.message = message;
    return frameModel.cellH;
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self reloadData];
    [self ScrollToEnd];
}

@end
