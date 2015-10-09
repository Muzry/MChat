//
//  LoginView.m
//  WeChat
//
//  Created by LiDan on 15/10/3.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "LoginView.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UserInfo.h"
#import "RegisterView.h"



@interface LoginView()
@property (nonatomic,weak) UIImageView *iCon;
@property (nonatomic,weak) UITextField *userName;
@property (nonatomic,weak) UITextField *password;
@property (nonatomic,weak) UIButton *login_Btn;

@end

@implementation LoginView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *iCon = [[UIImageView alloc]init];
        iCon.image = [UIImage imageNamed:@"DefaultProfileHead_phone"];
        self.iCon = iCon;
        
        
        
        NSString * user = [UserInfo sharedUserInfo].user;
        UITextField *userName = [[UITextField alloc]init];
        userName.placeholder = @"请输入用户名";
        if (user)
        {
            userName.text = user;
            userName.textAlignment = NSTextAlignmentCenter;
            userName.enabled = NO;
        }
        else
        {
            [userName setBackground:[UIImage resizeImageWihtImageName:@"operationbox_text"]];
            userName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
            userName.leftViewMode = UITextFieldViewModeAlways;
        }
        userName.delegate = self;
        self.userName = userName;
        
        UITextField *password = [[UITextField alloc]init];
        password.placeholder = @"请输入密码";
        password.secureTextEntry = YES;
        [password setBackground:[UIImage resizeImageWihtImageName:@"operationbox_text"]];
        
        UIImageView *lockView = [[UIImageView alloc]init];
        lockView.image = [UIImage imageNamed:@"Card_Lock"];
        lockView.frame = CGRectMake(0, 0, 30,password.height);
        lockView.contentMode = UIViewContentModeCenter;

        password.leftView = lockView;
        password.leftViewMode = UITextFieldViewModeAlways;
        password.delegate = self;
        self.password = password;
        
        UIButton *login_Btn = [[UIButton alloc]init];
        login_Btn.enabled = NO;
        [login_Btn setTitle:@"登陆" forState:UIControlStateNormal];
        [login_Btn setBackgroundImage:[UIImage resizeImageWihtImageName:@"fts_green_btn"] forState:UIControlStateNormal];
        [login_Btn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        self.login_Btn = login_Btn;
        
        [self addSubview:iCon];
        [self addSubview:userName];
        [self addSubview:password];
        [self addSubview:login_Btn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishRegister:) name:@"didFinishRegister" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:userName];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:password];
    }
    return self;
}

-(void)loginClick
{
    
    UserInfo *userInfo = [UserInfo sharedUserInfo];
    
    userInfo.user = self.userName.text;
    userInfo.pwd = self.password.text;
    
    [MBProgressHUD showMessage:@"正在登陆中..." toView:self.superview];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    __weak typeof (self) selfVc = self;
    
    app.registerOperation = NO;
    
    [self endEditing:YES];
    [app userLogin:^(XMPPResultType type) {
        [selfVc handleResultType:type];
    }];
    
}


-(void)handleResultType:(XMPPResultType) type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.superview];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
            {
                [self enterMainController];
                break;
            }
            case XMPPResultTypeLoginFailure:
            {
                [MBProgressHUD showError:@"用户名或密码不正确" toView:self.superview];
                break;
            }
            case XMPPResultTypeNetErr:
            {
                [MBProgressHUD showError:@"网络有问题" toView:self.superview];
            }
            default:
                break;
        }
    });

}

-(void)didFinishRegister:(NSNotification *)notification
{
    self.userName.text = [UserInfo sharedUserInfo].registerUserName;
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.enabled = NO;
    self.userName.leftView = nil;
    [self.userName setBackground:nil];
    [MBProgressHUD showSuccess:@"注册成功，请输入密码登陆" toView:self.superview];
}

-(void)textDidChange
{
    if ([self.userName hasText] && [self.password hasText]) {
        self.login_Btn.enabled = YES;
    }
    else
    {
        self.login_Btn.enabled = NO;
    }
}

-(void)enterMainController
{
    [UserInfo sharedUserInfo].loginStatus = YES;
    
    [UserInfo sharedUserInfo].saveuserInfoToSanbox;
    //来到主界面
    MainTabBarController *tabBarController = [[MainTabBarController alloc]init];
    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
    [self.window.rootViewController presentViewController:tabBarController animated:YES completion:nil];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iCon.width = 100;
    self.iCon.height = 100;
    self.iCon.x =  (self.width - self.iCon.width) / 2;
    self.iCon.y = 50;
    
    self.userName.width = self.width;
    self.userName.height = 40;
    self.userName.x = (self.width - self.userName.width) / 2;
    self.userName.y = self.iCon.y + self.iCon.height + 10;

    self.password.width = self.userName.width;
    self.password.height = 40;
    self.password.x = (self.width - self.password.width) / 2;
    self.password.y = self.userName.y + self.userName.height + 10;
    
    self.login_Btn.width = self.password.width;
    self.login_Btn.height = 40;
    self.login_Btn.x = (self.width - self.login_Btn.width) / 2;
    self.login_Btn.y = self.password.y + self.password.height + 10;
}
@end
