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
{
    NSFetchedResultsController *_resultsController;
}

@property(nonatomic,strong) NSArray *friends;

@end

@implementation ContactController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"通讯录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriends)];
    [self loadFriends];
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

-(void)loadFriends
{
    //获取上下文
    NSManagedObjectContext *context = [XmppTools sharedXmppTools].rosterStorage.mainThreadManagedObjectContext;
    
    //FetchRequest
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"XMPPUserCoreDataStorageObject"];
    
    //设置过滤和排序
    //过滤当前登录用户的好友
    NSString *jid = [UserInfo sharedUserInfo].JID;
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"streamBareJidStr = %@",jid];
    request.predicate = pre;
    
    //排序
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"displayName" ascending:YES];
    request.sortDescriptors = @[sort];
    
    //执行请求获取数据
    _resultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    _resultsController.delegate = self;
    
    NSError *err = nil;
    
    [_resultsController performFetch:&err];
    
    if (err) {
        NSLog(@"%@",err);
    }
}

#pragma mark 当数据的内容发生改变后，会调用这个方法

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultsController.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //获取对应的好友
    XMPPUserCoreDataStorageObject *friend = _resultsController.fetchedObjects [indexPath.row];
    
    cell.textLabel.text = friend.jidStr;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
