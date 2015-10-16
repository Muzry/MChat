//
//  RegisterController.m
//  WeChat
//
//  Created by LiDan on 15/10/8.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterView.h"

@interface RegisterController ()
@property (nonatomic,weak) UIView * registerView;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.title = @"注册账户";
    self.view.backgroundColor = [UIColor whiteColor];
    RegisterView * registerView = [[RegisterView alloc]init];
    self.registerView = registerView;
    [self.view addSubview:registerView];
    
    self.registerView.width = 300;
    self.registerView.height = 300;
    self.registerView.x = (ScreenWidth - self.registerView.width) / 2;
    self.registerView.y = 100;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardDismiss)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardDismiss
{
    [self.view endEditing:YES];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
