//
//  OtherWayLogin.m
//  WeChat
//
//  Created by LiDan on 15/10/7.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "RegisterView.h"
#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UserInfo.h"

@interface RegisterView()
@property (nonatomic,weak) UITextField *userName;
@property (nonatomic,weak) UITextField *password;
@property (nonatomic,weak) UIButton *register_Btn;
@end


@implementation RegisterView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UITextField *userName = [[UITextField alloc]init];
        userName.placeholder = @"请输入用户名";
        [userName setBackground:[UIImage resizeImageWihtImageName:@"operationbox_text"]];
        userName.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        userName.leftViewMode = UITextFieldViewModeAlways;
        self.userName = userName;
        
        UITextField *password = [[UITextField alloc]init];
        password.placeholder = @"请输入密码";
        password.secureTextEntry = YES;
        [password setBackground:[UIImage resizeImageWihtImageName:@"operationbox_text"]];
        password.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        password.leftViewMode = UITextFieldViewModeAlways;
        self.password = password;
        
        
        UIButton *register_Btn = [[UIButton alloc]init];
        [register_Btn setTitle:@"注册账户" forState:UIControlStateNormal];
        [register_Btn setBackgroundImage:[UIImage resizeImageWihtImageName:@"fts_green_btn"] forState:UIControlStateNormal];
        [register_Btn addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
        self.register_Btn = register_Btn;
        
        [self addSubview:userName];
        [self addSubview:password];
        [self addSubview:register_Btn];
    }
    return self;
}

-(void)registerClick
{
    
}

-(void)handleResultType:(XMPPResultType) type
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.superview];
        switch (type) {
            case XMPPResultTypeLoginSuccess:
            {
                break;
            }
            case XMPPResultTypeLoginFailure:
            {
                [MBProgressHUD showError:@"用户名或密码不正确" toView:self.superview];
                break;
            }
            case XMPPResultTypeNetErr:
            {
                [MBProgressHUD showError:@"网络有问题"  toView:self.superview];
            }
            default:
                break;
        }
    });
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userName.width = 255;
    self.userName.height = 40;
    self.userName.x = (self.width - self.userName.width) / 2;
    self.userName.y = self.height * 0.3;
    
    self.password.width = self.userName.width;
    self.password.height = 40;
    self.password.x = (self.width - self.password.width) / 2;
    self.password.y = self.userName.y + self.userName.height + 10;
    
    self.register_Btn.width = self.userName.width;
    self.register_Btn.height = 40;
    self.register_Btn.x = (self.width - self.register_Btn.width) / 2;
    self.register_Btn.y = self.password.y + self.password.height + 10;
    
}
@end
