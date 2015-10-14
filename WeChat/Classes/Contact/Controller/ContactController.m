//
//  ContactController.m
//  WeChat
//
//  Created by LiDan on 15/10/5.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "ContactController.h"
#import "AddFriendsController.h"

@interface ContactController ()<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong) NSFetchedResultsController *resultsFriends;

@property(nonatomic,strong) NSMutableArray *resultsNewFriends;

@end


@implementation ContactController

-(NSMutableArray *)resultsNewFriends
{
    if (!_resultsNewFriends)
    {
        _resultsNewFriends = [NSMutableArray array];
    }
    
    return _resultsNewFriends;
}

-(NSFetchedResultsController *)resultsFriends
{
    if (!_resultsFriends)
    {
    // 指定查询的实体
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    // 显示的名称排序
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    
    // 添加排序
    request.sortDescriptors = @[sort1];
    
    // 添加谓词过滤器
    request.predicate = [NSPredicate predicateWithFormat:@"!(subscription CONTAINS 'both')"];
    
    // 添加上下文
    NSManagedObjectContext *ctx = [XmppTools sharedXmppTools].rosterStorage.mainThreadManagedObjectContext;
    
    // 实例化结果控制器
    _resultsFriends = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:ctx sectionNameKeyPath:nil cacheName:nil];
    
    // 设置他的代理
    _resultsFriends.delegate = self;
    }
    
    return _resultsFriends;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通讯录";
    [self.resultsFriends performFetch:NULL];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriends)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addFriends
{
    AddFriendsController *addfriends = [[AddFriendsController alloc]init];
    
    [self.navigationController pushViewController:addfriends animated:YES];
}


#pragma mark 当数据的内容发生改变后，会调用这个方法

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.resultsNewFriends.count;
    }
    else
    {
        return self.resultsFriends.fetchedObjects.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"ContactCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    XMPPUserCoreDataStorageObject *user = nil;
    if (indexPath.section == 0)
    {
        XMPPJID * Jid = [self.resultsNewFriends objectAtIndex:indexPath.row];
        cell.textLabel.text = Jid;
        cell.detailTextLabel.text = @"新增";
    }
    else
    {
        user = [self.resultsFriends.fetchedObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = user.jidStr;
        cell.detailTextLabel.text = @"好友";
    }
    // subscription
    // 如果是none表示对方还没有确认
    // to   我关注对方
    // from 对方关注我
    // both 互粉
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        XMPPUserCoreDataStorageObject *friend = _resultsFriends.fetchedObjects[indexPath.row];
        XMPPJID *friendJid = friend.jid;
        [[XmppTools sharedXmppTools].roster removeUser:friendJid];
    }
}


@end
