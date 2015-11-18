//
//  DetailController.m
//  WeChat
//
//  Created by LiDan on 15/10/11.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "DetailController.h"
#import "XMPPvCardTemp.h"
#import "DetailCell.h"
#import "DetailModel.h"
#import "XMPPvCardTemp.h"
#import "DetailProfileCrontroller.h"
#import "AreaPickerView.h"

@interface DetailController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,DetailProfileCrontrollerDelegate>

@property (nonatomic,strong) NSMutableArray *Groups;
@property (nonatomic,weak) DetailCell * detailcell;

@end

@implementation DetailController

-(NSMutableArray *)Groups
{
    if (!_Groups)
    {
        XMPPvCardTemp *myVCard = [XmppTools sharedXmppTools].vCard.myvCardTemp;
        
        DetailModel *avatar = [[DetailModel alloc] init];
        avatar.titleName = @"头像";
        avatar.tag = 2;
        
        DetailModel *nickName = [[DetailModel alloc]init];
        nickName.titleName = @"名字";
        nickName.detailsContent = [UserInfo sharedUserInfo].user;
        nickName.tag = 1;
        if (myVCard.nickname)
        {
            nickName.detailsContent = myVCard.nickname;
        }
        
        DetailModel *account = [[DetailModel alloc]init];
        account.titleName = @"微信号";
        account.detailsContent = [UserInfo sharedUserInfo].user;
        account.tag = 0;
        
        NSMutableArray *group1 = [NSMutableArray array];
        [group1 addObject:avatar];
        [group1 addObject:nickName];
        [group1 addObject:account];

        DetailModel * profession = [[DetailModel alloc] init];
        profession.titleName = @"职业";
        profession.detailsContent = @"未设置";
        profession.tag = 1;
        if (myVCard.orgName)
        {
            profession.detailsContent = myVCard.orgName;
        }
        
        DetailModel *location = [[DetailModel alloc]init];
        location.titleName = @"地区";
        location.detailsContent = @"未设置";
        location.tag = 4;
        if (myVCard.note)
        {
            location.detailsContent = myVCard.note;
        }

        
        DetailModel *gender = [[DetailModel alloc]init];
        gender.titleName = @"性别";
        gender.detailsContent = @"男";
        if (myVCard.role)
        {
            gender.detailsContent = myVCard.role;
        }
        gender.tag = 3;
        
        DetailModel *email = [[DetailModel alloc]init];
        email.titleName = @"邮箱";
        email.detailsContent = @"未设置";
        email.tag = 1;
        if (myVCard.mailer)
        {
            email.detailsContent = myVCard.mailer;
        }
        
        DetailModel *birthday = [[DetailModel alloc]init];
        birthday.titleName = @"生日";
        birthday.detailsContent = @"未设置";
        birthday.tag = 5;
        if (myVCard.title)
        {
            birthday.detailsContent = myVCard.title;
        }
        
        NSMutableArray *group2 = [NSMutableArray array];
        [group2 addObject:profession];
        [group2 addObject:location];
        [group2 addObject:gender];
        [group2 addObject:email];
        [group2 addObject:birthday];
        
        _Groups = [NSMutableArray array];
        [_Groups addObject:group1];
        [_Groups addObject:group2];
    }
    return _Groups;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人信息";
    [self.view setBackgroundColor:SelfColor(240, 239, 244)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.Groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *titiles = self.Groups[section];
    return titiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSArray *titles = self.Groups[indexPath.section];
    DetailModel *detail = titles[indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        DetailCell *detailcell = [[DetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell = detailcell;
        self.detailcell = detailcell;
        SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        [cell.contentView addSubview:topseparator];
    }
    else
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.detailTextLabel.text = detail.detailsContent;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        SeparatorView *topseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
        SeparatorView *bottomseparator = [[SeparatorView alloc] initWithFrame:CGRectMake(0, cell.height, ScreenWidth, 0.5)];
        [cell.contentView addSubview:topseparator];
        [cell.contentView addSubview:bottomseparator];
    }
    if (!(indexPath.section == 0 && indexPath.row == 2))
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = detail.titleName;
    cell.tag = detail.tag;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的tag
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSInteger tag = cell.tag;
    if (tag == 1)
    {
        DetailProfileCrontroller *detialVc = [[DetailProfileCrontroller alloc] init];
        detialVc.cell = cell;
        [self.navigationController pushViewController:detialVc animated:YES];
        detialVc.delegate = self;
    }
    else if (tag == 2)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从相机" otherButtonTitles:@"从相册", nil];
        [sheet showInView:[[UIApplication sharedApplication].windows lastObject]];
        sheet.tag = 1;

    }
    else if (tag == 3)
    {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
        [sheet showInView:[[UIApplication sharedApplication].windows lastObject]];
        sheet.tag = 2;
    }
    else if (tag == 4)
    {

        
        UIAlertController* alertVc=[UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        AreaPickerView *areaPicker = [[AreaPickerView alloc] init];
        areaPicker.x = 20;
        areaPicker.y = -50;
        
        UIAlertAction* cancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        UIAlertAction* ok=[UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:
        ^(UIAlertAction *action)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:1 inSection:1];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
            cell.detailTextLabel.text = areaPicker.resultSting;
            [self didFinishSave];
        }];

        [alertVc.view addSubview:areaPicker];
        [alertVc addAction:ok];
        [alertVc addAction:cancel];
        
        [self presentViewController:alertVc animated:YES completion:nil];

    }
    else if (tag == 5)
    {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        NSDate *maxDate = [dateFormatter dateFromString:@"2016-01-01"];
        datePicker.maximumDate = maxDate;
        datePicker.x = 20;
        datePicker.y = 25;
        
        UIAlertController* alertVc=[UIAlertController alertControllerWithTitle:@"请选择\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction* cancel=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:nil];
        UIAlertAction* ok=[UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:
        ^(UIAlertAction *action)
        {
            NSIndexPath *path = [NSIndexPath indexPathForRow:4 inSection:1];
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
            cell.detailTextLabel.text = [dateFormatter stringFromDate:datePicker.date];
            [self didFinishSave];
        }];
        [alertVc.view addSubview:datePicker];
        [alertVc addAction:ok];
        [alertVc addAction:cancel];


        [self presentViewController:alertVc animated:YES completion:nil];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -编辑个人信息的代理
-(void)didFinishSave
{
    XMPPvCardTemp *vCard = [XmppTools sharedXmppTools].vCard.myvCardTemp;
    vCard.photo = UIImageJPEGRepresentation(self.detailcell.avatar.imageView.image,0.7f);
    vCard.nickname = [self getLabelTextFromCellSection:0 Row:1].detailTextLabel.text;
    vCard.orgName = [self getLabelTextFromCellSection:1 Row:0].detailTextLabel.text;
    vCard.note = [self getLabelTextFromCellSection:1 Row:1].detailTextLabel.text;
    vCard.role = [self getLabelTextFromCellSection:1 Row:2].detailTextLabel.text;
    vCard.mailer = [self getLabelTextFromCellSection:1 Row:3].detailTextLabel.text;
    vCard.title = [self getLabelTextFromCellSection:1 Row:4].detailTextLabel.text;
    //更新服务器
    [[XmppTools sharedXmppTools].vCard updateMyvCardTemp:vCard];
    
    if ([self.delegate respondsToSelector:@selector(didUpdateInfo)])
    {
        [self.delegate didUpdateInfo];
    }
}


-(UITableViewCell *)getLabelTextFromCellSection:(NSInteger)section Row:(NSInteger)row
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
    return [self.tableView cellForRowAtIndexPath:path];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1)
    {
        if (buttonIndex == 2)
        {
            return;
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        imagePicker.delegate = self;
        
        imagePicker.allowsEditing = YES;
        
        if(buttonIndex == 0)
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        [self presentViewController:imagePicker animated:YES completion:
         ^{
             [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
         }];
    }
    else if (actionSheet.tag == 2)
    {
        NSIndexPath *path = [NSIndexPath indexPathForRow:2 inSection:1];
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
        if(buttonIndex == 0)
        {
            cell.detailTextLabel.text = @"男";
        }
        else
        {
            cell.detailTextLabel.text = @"女";
        }
        [self didFinishSave];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.detailcell.avatar setImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    [self didFinishSave];
    if ([self.delegate respondsToSelector:@selector(didUpdateInfo)])
    {
        [self.delegate didUpdateInfo];
    }
}


@end
