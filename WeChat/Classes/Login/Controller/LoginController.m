//
//  LoginNavigationController.m
//  WeChat
//
//  Created by LiDan on 15/10/4.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "OtherWayLogin.h"

@interface LoginController ()
@property (nonatomic,weak) UIView * loginView;

@property (nonatomic,weak) UIButton *otherLogin;
@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setInit
{
    self.view.backgroundColor = [UIColor whiteColor];
    LoginView * loginView = [[LoginView alloc]init];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    
    
    UIButton *otherLogin = [[UIButton alloc]init];
    [otherLogin setTitle:@"其他方式登陆" forState:UIControlStateNormal];
    [otherLogin setBackgroundColor:[UIColor clearColor]];
    [otherLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherLogin addTarget:self action:@selector(otherWayLogin:) forControlEvents:UIControlEventTouchUpInside];
    otherLogin.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    self.otherLogin = otherLogin;
    [self.view addSubview:otherLogin];
    
    self.loginView.width = 300;
    self.loginView.height = 400;
    self.loginView.x = (ScreenWidth - self.loginView.width) / 2;
    self.loginView.y = 0;
    
    self.otherLogin.width = 150;
    self.otherLogin.height = 30;
    self.otherLogin.x = (ScreenWidth - self.otherLogin.width) / 2;
    self.otherLogin.y = ScreenHeight * 0.9;

}

-(void)otherWayLogin:(UIButton*)btn
{
    UIViewController *viewController = [[UIViewController alloc] init];
    MainNavigationController * otherNavigationController = [[MainNavigationController alloc]initWithRootViewController:viewController];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    viewController.title = @"其他方式登陆";
    viewController.view = [[OtherWayLogin alloc]init];
    [viewController.view setBackgroundColor:[UIColor whiteColor]];
    [self presentViewController:otherNavigationController animated:YES completion:nil];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
