//
//  LoginView.m
//  WeChat
//
//  Created by LiDan on 15/10/3.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "LoginView.h"

@interface LoginView()
@property (nonatomic,weak) UIImageView *iCon;
@property (nonatomic,weak) UITextField *userName;
@property (nonatomic,weak) UITextField *password;
@property (nonatomic,weak) UIButton *login_Btn;
@property (nonatomic,weak) UIButton *register_Btn;
@end

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *iCon = [[UIImageView alloc]init];
        [iCon setBackgroundColor:[UIColor grayColor]];
        self.iCon = iCon;
        
        UITextField *userName = [[UITextField alloc]init];
        userName.placeholder = @"用户名";
        userName.backgroundColor = [UIColor redColor];
        self.userName = userName;
        
        UITextField *password = [[UITextField alloc]init];
        password.placeholder = @"密码";
        password.secureTextEntry = YES;
        password.backgroundColor = [UIColor redColor];
        self.password = password;
        
        UIButton *login_Btn = [[UIButton alloc]init];
        [login_Btn setTitle:@"登陆" forState:UIControlStateNormal];
        [login_Btn setBackgroundColor:[UIColor colorWithRed:85 / 255.0 green:201 / 255.0 blue:91/255.0 alpha:1.0]];
        self.login_Btn = login_Btn;
        
        UIButton *register_Btn = [[UIButton alloc]init];
        [register_Btn setTitle:@"没有账号？点击注册" forState:UIControlStateNormal];
        [register_Btn setBackgroundColor:[UIColor whiteColor]];
        [register_Btn setTitleColor:[UIColor colorWithRed:105/255.0 green:177/255.0 blue:250/255.0 alpha:1]forState:UIControlStateNormal];
        register_Btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        self.register_Btn= register_Btn;

        
        [self addSubview:iCon];
        [self addSubview:userName];
        [self addSubview:password];
        [self addSubview:login_Btn];
        [self addSubview:register_Btn];
    }
    return self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iCon.width = 100;
    self.iCon.height = 100;
    self.iCon.x =  (ScreenWidth - self.iCon.width) / 2;
    self.iCon.y = ScreenHeight * 0.1;
    
    self.userName.width = 200;
    self.userName.height = 30;
    self.userName.x = (ScreenWidth - self.userName.width) / 2;
    self.userName.y = self.iCon.y + self.iCon.height + 10;
    
    self.password.width = 200;
    self.password.height = 30;
    self.password.x = (ScreenWidth - self.password.width) / 2;
    self.password.y = self.userName.y + self.userName.height + 10;
    
    self.login_Btn.width = 100;
    self.login_Btn.height = 30;
    self.login_Btn.x = (ScreenWidth - self.login_Btn.width) / 2;
    self.login_Btn.y = self.password.y + self.password.height + 10;
    
    self.register_Btn.width = 150;
    self.register_Btn.height = 30;
    self.register_Btn.x = (ScreenWidth - self.register_Btn.width) / 2;
    self.register_Btn.y = ScreenHeight * 0.9;
}
@end
