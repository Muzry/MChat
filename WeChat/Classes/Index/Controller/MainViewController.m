//
//  MainViewController.m
//  WeChat
//
//  Created by LiDan on 15/10/5.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MainViewController.h"
#import "WeChatCell.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *plist = [NSArray arrayWithContentsOfFile:[self recordPath]];
    if (plist)
    {
        [UserInfo sharedUserInfo].msgRecordArray = [plist mutableCopy];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"SendMessage" object:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserInfo sharedUserInfo].msgRecordArray.count;
}

-(void)receiveMessage:(NSNotification *)notification
{
    int i = 0;
    for (NSDictionary *dict in [UserInfo sharedUserInfo].msgRecordArray)
    {
        if ([((XMPPJID*)dict[@"username"]).user isEqualToString:((XMPPJID*)notification.userInfo[@"username"]).user])
        {
            [UserInfo sharedUserInfo].msgRecordArray[i] = notification.userInfo;
            [self.tableView reloadData];
            return ;
        }
        i++;
    }
    [[UserInfo sharedUserInfo].msgRecordArray addObject:notification.userInfo];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeChatCell *cell = [WeChatCell weChatCellWithTableView:tableView AndDict:[UserInfo sharedUserInfo].msgRecordArray[indexPath.row]];
    SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, 0.5)];
    [cell.contentView addSubview:topseparator];
    [cell.contentView addSubview:bottomseparator];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSString*)recordPath
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = [NSString stringWithFormat:@"records%@.plist",[UserInfo sharedUserInfo].user];
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:filename];
}


@end
