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
        UIImageView *iCon = [[UIImageView alloc]init];
        iCon.image = [UIImage imageNamed:@"DefaultHead"];
        self.iCon = iCon;
        
        UITextField *userName = [[UITextField alloc]init];
        userName.placeholder = @"用户名";
        self.userName = userName;
        
        UITextField *password = [[UITextField alloc]init];
        password.placeholder = @"密码";
        password.secureTextEntry = YES;
        self.password = password;
        
        UIButton *login_Btn = [[UIButton alloc]init];
        [login_Btn setTitle:@"登陆" forState:UIControlStateNormal];
        [login_Btn setBackgroundColor:[UIColor colorWithRed:85 / 255.0 green:201 / 255.0 blue:91/255.0 alpha:1.0]];
        self.login_Btn = login_Btn;
        
        
        UIButton *register_Btn = [[UIButton alloc]init];
        [register_Btn setTitle:@"没有账号？点击注册" forState:UIControlStateNormal];
        [register_Btn setBackgroundColor:[UIColor clearColor]];
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
    self.iCon.x =  (self.width - self.iCon.width) / 2;
    self.iCon.y = 100;
    
    self.userName.width = self.width;
    self.userName.height = 30;
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
    
    self.register_Btn.width = 150;
    self.register_Btn.height = 40;
    self.register_Btn.x = (self.width - self.register_Btn.width) / 2;
    self.register_Btn.y = self.height - 60;

}
@end
