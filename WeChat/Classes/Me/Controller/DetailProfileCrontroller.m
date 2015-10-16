//
//  DetailProfileCrontroller.m
//  WeChat
//
//  Created by LiDan on 15/10/11.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "DetailProfileCrontroller.h"

@interface DetailProfileCrontroller ()
@property (nonatomic,weak) UITextField *textField;
@end

@implementation DetailProfileCrontroller

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:SelfColor(240, 239, 244)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.title = self.cell.textLabel.text;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = SelfColor(1, 183, 51);
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *distextAttrs = [NSMutableDictionary dictionary];
    distextAttrs[NSForegroundColorAttributeName] = SelfColor(22, 83, 46);
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:distextAttrs forState:UIControlStateDisabled];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)saveBtnClick
{
    self.cell.detailTextLabel.text = self.textField.text;
    
    [self.cell layoutSubviews];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(didFinishSave)])
    {
        [self.delegate didFinishSave];
    }
}

-(void)textDidChange
{
    if (!self.textField.hasText || [self.cell.detailTextLabel.text isEqualToString:self.textField.text])
    {
         self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

#pragma mark - Table view data source

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
    NSString *ID = @"DetailProfile";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    UITextField *textfield = [[UITextField alloc]init];
    textfield.x = 8;
    textfield.y = 0;
    textfield.height = cell.height;
    textfield.width = self.view.width- textfield.x;
    textfield.text = self.cell.detailTextLabel.text;
    textfield.clearButtonMode = UITextFieldViewModeAlways;
    textfield.font = [UIFont systemFontOfSize:16];
    self.textField = textfield;
    
    [cell addSubview:textfield];
    
    SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, cell.height, ScreenWidth, 0.5)];
    [cell addSubview:topseparator];
    [cell addSubview:bottomseparator];
    
    NSNotification *notification =[NSNotification notificationWithName:UITextFieldTextDidChangeNotification object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    return cell;
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


@end
