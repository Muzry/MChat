//
//  MainViewController.m
//  WeChat
//
//  Created by LiDan on 15/10/5.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MainViewController.h"
#import "WeChatCell.h"
#import "MessageViewController.h"
#import "XMPPvCardTemp.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filename = [NSString stringWithFormat:@"records%@.plist",[UserInfo sharedUserInfo].user];
    
    
    NSArray *plist = [NSArray arrayWithContentsOfFile:[[pathList objectAtIndex:0] stringByAppendingPathComponent:filename]];
    if (plist)
    {
        [UserInfo sharedUserInfo].msgRecordArray = [plist mutableCopy];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage) name:@"SendMessage" object:nil];
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

-(void)receiveMessage
{
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    MessageViewController *msgController = [[MessageViewController alloc]init];
    XMPPvCardTemp *vCard = nil;
    XMPPJID *Jid = [XMPPJID jidWithString:[UserInfo sharedUserInfo].msgRecordArray[indexPath.row][@"username"]];
    msgController.nickName = Jid.user;
    msgController.Jid = Jid;
    vCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:Jid shouldFetch:YES];
    if (vCard.nickname != nil)
    {
        msgController.nickName = vCard.nickname;
    }
    
    [self.navigationController pushViewController:msgController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
