//
//  AddFriendsController.m
//  WeChat
//
//  Created by LiDan on 15/10/14.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "AddFriendsController.h"

@interface AddFriendsController()

@property (nonatomic,weak) UITextField *textField;

@end

@implementation AddFriendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:SelfColor(240, 239, 244)];
    self.title = @"添加好友";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"AddFriendCell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    UITextField *textfield = [[UITextField alloc]init];
    textfield.x = 8;
    textfield.y = 0;
    textfield.height = cell.height;
    textfield.width = self.view.width- textfield.x;
    textfield.clearButtonMode = UITextFieldViewModeAlways;
    textfield.font = [UIFont systemFontOfSize:16];
    self.textField = textfield;
    
    SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, cell.height, ScreenWidth, 0.5)];
    SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    [cell addSubview:textfield];
    [cell addSubview:topseparator];
    [cell addSubview:bottomseparator];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width,20)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end