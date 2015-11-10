//
//  FriendController.m
//  WeChat
//
//  Created by LiDan on 15/10/16.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "DetailFriendController.h"
#import "DetailFriendCell.h"
#import "XMPPvCardTemp.h"
#import "MessageViewController.h"


@interface DetailFriendController()
@end

@implementation DetailFriendController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:SelfColor(240, 239, 244)];
    self.title = @"详细资料";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, 0.5)];
    SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    if(indexPath.section == 0)
    {
        DetailFriendCell *cell = [[DetailFriendCell alloc] init];
        cell.Jid = self.account;
        [cell setInit];
        bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 88, ScreenWidth, 0.5)];
        [cell addSubview:topseparator];
        [cell addSubview:bottomseparator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"tagCell"];
        
        cell.textLabel.text = @"设置备注和标签";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:topseparator];
        [cell addSubview:bottomseparator];
        return cell;
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"LocationCell"];
         XMPPvCardTemp *vCard = nil;
        vCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:self.account shouldFetch:YES];
        cell.textLabel.text = @"地区";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        UILabel *area = [[UILabel alloc]init];
        area.text = @"未设置";
        area.font = [UIFont systemFontOfSize:15];
        area.x = 80;
        area.height = 44;
        area.y = 0;
        area.width = 100;
        if (vCard.note)
        {
            area.text = vCard.note;
        }
        
        [cell addSubview:area];
        [cell addSubview:topseparator];
        [cell addSubview:bottomseparator];
        return cell;
    }
    else if(indexPath.section == 2 && indexPath.row == 1)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PhotoCell"];
        bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 120, ScreenWidth, 0.5)];
        cell.textLabel.text = @"个人相册";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell addSubview:topseparator];
        [cell addSubview:bottomseparator];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"buttonCell"];
        
        cell.backgroundColor = [UIColor clearColor];
        UIButton *sendMessage = [[UIButton alloc]init];
        [sendMessage setTitle:@"发消息" forState:UIControlStateNormal];
        [sendMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sendMessage addTarget:self action:@selector(sendMessageClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *vedioMessage = [[UIButton alloc]init];
        [vedioMessage setTitle:@"视频聊天" forState:UIControlStateNormal];
        [vedioMessage setTitleColor:SelfColor(93, 93, 93) forState:UIControlStateNormal];
        [vedioMessage addTarget:self action:@selector(vedioMessageClick) forControlEvents:UIControlEventTouchUpInside];
        
        sendMessage.x = 10;
        sendMessage.y = 15;
        sendMessage.width = ScreenWidth - 2 *sendMessage.x;
        sendMessage.height = 40;
        [sendMessage  setBackgroundImage:[UIImage resizeImageWihtImageName:@"GreenBigBtn"] forState:UIControlStateNormal];
        
        vedioMessage.x = sendMessage.x;
        vedioMessage.y = 15 * 2 + sendMessage.height;
        vedioMessage.width = sendMessage.width;
        vedioMessage.height = 40;
        [vedioMessage setBackgroundImage:[UIImage resizeImageWihtImageName:@"WhiteBigBtn"] forState:UIControlStateNormal];
        
        [cell addSubview:sendMessage];
        [cell addSubview:vedioMessage];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 88;
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        return 120;
    }
    else if(indexPath.section == 2 && indexPath.row == 2)
    {
        return 120;
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width,20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width,16)];
        view.backgroundColor = [UIColor clearColor];
        return view;
}

-(void)vedioMessageClick
{
    NSLog(@"视频聊天");
}

-(void)sendMessageClick
{
    MessageViewController *msgController = [[MessageViewController alloc]init];
    XMPPvCardTemp *vCard = nil;
    msgController.nickName = self.account.user;
    msgController.Jid = self.account;
    vCard = [[XmppTools sharedXmppTools].vCard vCardTempForJID:self.account shouldFetch:YES];
    if (vCard != nil)
    {
        msgController.nickName = vCard.nickname;
    }
    [self.navigationController pushViewController:msgController animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
