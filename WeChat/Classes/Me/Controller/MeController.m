//
//  MeController.m
//  WeChat
//
//  Created by LiDan on 15/10/5.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MeController.h"
#import "MeMainCell.h"
#import "XMPPvCardTemp.h"
#import "DetailController.h"

@interface MeController ()<UIActionSheetDelegate,DetailControllerDelegate>

@end

@implementation MeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:SelfColor(240, 239, 244)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    
-(void)loginOut
{
    [[XmppTools sharedXmppTools] userLogout];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if  (indexPath.section == 0)
    {
        cell =[[MeMainCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 88, ScreenWidth, 0.5)];
        [cell.contentView addSubview:topseparator];
        [cell.contentView addSubview:bottomseparator];
    }
    else if(indexPath.section == 1)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text = @"退出登录";
        cell.textLabel.textColor = SelfColor(255, 97, 89);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, cell.height, ScreenWidth, 0.5)];
        [cell.contentView addSubview:topseparator];
        [cell.contentView addSubview:bottomseparator];

    }

    return cell;
}
-(void)didUpdateInfo
{
    [self.tableView reloadData];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return 88;
    }
    else
    {
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 16;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width,16)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0)
    {
        DetailController *detailVc = [[DetailController alloc] init];
        [self.navigationController pushViewController:detailVc animated:YES];
        detailVc.delegate = self;
    }
    else if (indexPath.section == 1)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"您真的要退出程序吗？" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"退出登录" otherButtonTitles:@"取消", nil];
        [sheet showInView:self.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self loginOut];
    }
    else
    {
        return ;
    }
}

@end
