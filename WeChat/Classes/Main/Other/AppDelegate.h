//
//  AppDelegate.h
//  WeChat
//
//  Created by LiDan on 15/10/3.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
{
    XMPPResultTypeLoginSuccess,//登陆成功
    XMPPResultTypeLoginFailure,// 登录失败
    XMPPResultTypeNetErr //网络问题
}XMPPResultType;
typedef void (^XMPPResultBlock)(XMPPResultType type);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//注册操作
@property (nonatomic,assign,getter=isRegisterOperation) BOOL registerOperation;

//用户登陆
-(void)userLogin:(XMPPResultBlock )resultBlock;

//用户注册
-(void)userRegister:(XMPPResultBlock)resultBlock;

//用户登出
-(void)userLogout;
@end

