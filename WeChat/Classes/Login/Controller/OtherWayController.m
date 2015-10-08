//
//  OtherWayController.m
//  WeChat
//
//  Created by LiDan on 15/10/8.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "OtherWayController.h"
#import "LoginView.h"

@interface OtherWayController ()
@property (nonatomic,weak) UIView * loginView;
@end

@implementation OtherWayController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.title = @"其他账号登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    
    LoginView * loginView = [[LoginView alloc]init];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    
    self.loginView.width = 300;
    self.loginView.height = 350;
    self.loginView.x = (ScreenWidth - self.loginView.width) / 2;
    self.loginView.y = 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
