//
//  MainViewController.m
//  WeChat
//
//  Created by LiDan on 15/10/5.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MainViewController.h"
#import "WeChatCell.h"

@interface MainViewController ()

@property (nonatomic,strong) NSMutableArray *msgRecordArray;

@end

@implementation MainViewController

-(NSMutableArray *)msgRecordArray
{
    if (!_msgRecordArray)
    {
        _msgRecordArray = [NSMutableArray array];
    }
    return _msgRecordArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"SendMessage" object:nil];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.msgRecordArray.count;
}

-(void)receiveMessage:(NSNotification *)notification
{
    int i = 0;
    for (NSDictionary *dict in self.msgRecordArray)
    {
        i++;
        if (dict[@"username"] == notification.userInfo[@"username"])
        {
            self.msgRecordArray[i] = notification.userInfo;
            return ;
        }
    }
    [self.msgRecordArray addObject:notification.userInfo];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeChatCell *cell = [WeChatCell weChatCellWithTableView:tableView AndDict:self.msgRecordArray[indexPath.row]];
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



@end
