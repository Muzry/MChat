//
//  LoginMainView.m
//  WeChat
//
//  Created by LiDan on 15/10/4.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "LoginMainView.h"
#import "LoginView.h"

@interface LoginMainView()

@property (nonatomic,weak) UIView * loginView;

@property (nonatomic,weak) UIButton *otherLogin;

@end

@implementation LoginMainView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        LoginView * loginView = [[LoginView alloc]init];
        self.loginView = loginView;
        [self addSubview:loginView];
        

        UIButton *otherLogin = [[UIButton alloc]init];
        [otherLogin setTitle:@"其他方式登陆" forState:UIControlStateNormal];
        [otherLogin setBackgroundColor:[UIColor clearColor]];
        [otherLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        otherLogin.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        self.otherLogin = otherLogin;
        [self addSubview:otherLogin];
        
    }
    
    return self;
}


-(void)layoutSubviews
{
    self.loginView.width = 300;
    self.loginView.height = 400;
    self.loginView.x = (ScreenWidth - self.loginView.width) / 2;
    self.loginView.y = 0;
    
    self.otherLogin.width = 150;
    self.otherLogin.height = 30;
    self.otherLogin.x = (ScreenWidth - self.otherLogin.width) / 2;
    self.otherLogin.y = ScreenHeight * 0.9;
}
@end
