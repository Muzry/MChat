//
//  LoginNavigationController.m
//  WeChat
//
//  Created by LiDan on 15/10/4.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "LoginController.h"
#import "LoginView.h"
#import "OtherLoginController.h"
#import "MainNavigationController.h"
#import "RegisterController.h"
#import "RegisterView.h"

@interface LoginController ()
@property (nonatomic,weak) UIView * loginView;
@property (nonatomic,weak) UIButton *registerBtn;
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
    self.title = @"登陆";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardDismiss)];
    [self.view addGestureRecognizer:tapGesture];
    
    LoginView * loginView = [[LoginView alloc]init];
    self.loginView = loginView;
    [self.view addSubview:loginView];
    
    UIButton *registerBtn = [[UIButton alloc]init];
    [registerBtn setTitle:@"没有账号？点击注册" forState:UIControlStateNormal];
    [registerBtn setBackgroundColor:[UIColor clearColor]];
    [registerBtn setTitleColor:[UIColor colorWithRed:105/255.0 green:177/255.0 blue:250/255.0 alpha:1]forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [registerBtn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    self.registerBtn = registerBtn;
    [self.view addSubview:registerBtn];
    
    UIButton *otherLogin = [[UIButton alloc]init];
    [otherLogin setTitle:@"其他账号登陆" forState:UIControlStateNormal];
    [otherLogin setBackgroundColor:[UIColor clearColor]];
    [otherLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherLogin addTarget:self action:@selector(otherWayLogin) forControlEvents:UIControlEventTouchUpInside];
    otherLogin.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    self.otherLogin = otherLogin;
    [self.view addSubview:otherLogin];
    
    self.loginView.width = 300;
    self.loginView.height = 300;
    self.loginView.x = (ScreenWidth - self.loginView.width) / 2;
    self.loginView.y = 0;
    
    self.registerBtn.width = self.loginView.width;
    self.registerBtn.height = 40;
    self.registerBtn.x = (ScreenWidth - self.registerBtn.width) / 2;
    self.registerBtn.y = self.loginView.y + self.loginView.height + 10;
    
    self.otherLogin.width = loginView.width;
    self.otherLogin.height = 30;
    self.otherLogin.x = (ScreenWidth - self.otherLogin.width) / 2;
    self.otherLogin.y = ScreenHeight * 0.82;
}

-(void)keyboardDismiss
{
    [self.view endEditing:YES];
}

-(void)otherWayLogin
{
    OtherLoginController *viewController = [[OtherLoginController alloc] init];
    MainNavigationController * otherNavigationController = [[MainNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:otherNavigationController animated:YES completion:nil];
}

-(void)registerClick
{
    RegisterController *viewController = [[RegisterController alloc] init];
    MainNavigationController * registerController = [[MainNavigationController alloc]initWithRootViewController:viewController];
    [self presentViewController:registerController animated:YES completion:nil];
}


@end
