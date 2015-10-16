//
//  OtherLoginController.m
//  WeChat
//
//  Created by LiDan on 15/10/8.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "OtherLoginController.h"
#import "OtherWayLogin.h"

@interface OtherLoginController ()
@property (nonatomic,weak) UIView * otherWayView;
@end

@implementation OtherLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    self.title = @"其他账号登陆";
    self.view.backgroundColor = [UIColor whiteColor];
    OtherWayLogin * otherWayView = [[OtherWayLogin alloc]init];
    self.otherWayView = otherWayView;
    [self.view addSubview:otherWayView];
    
    self.otherWayView.width = 300;
    self.otherWayView.height = 300;
    self.otherWayView.x = (ScreenWidth - self.otherWayView.width) / 2;
    self.otherWayView.y = 0;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardDismiss)];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)keyboardDismiss
{
    [self.view endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
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
