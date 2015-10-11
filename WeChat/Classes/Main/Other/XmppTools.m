//
//  XmppTools.m
//  WeChat
//
//  Created by LiDan on 15/10/9.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "XmppTools.h"
#import "LoginController.h"
#import "MainNavigationController.h"
#import "MainTabBarController.h"

@interface XmppTools ()<XMPPStreamDelegate>
{
    XMPPStream * _xmppStream;
    XMPPResultBlock _resultBlock;
    
    XMPPvCardCoreDataStorage * _vCardStorage;
    
    XMPPvCardAvatarModule * _avatar;
}
// 1. 初始化XMPPStream
-(void)setupXMPPStream;


// 2.连接到服务器
-(void)connectToHost;

// 3.连接到服务成功后，再发送密码授权
-(void)sendPwdToHost;


// 4.授权成功后，发送"在线" 消息
-(void)sendOnlineToHost;
@end


@implementation XmppTools

singleton_implementation(XmppTools)


#pragma mark  -私有方法

#pragma mark 初始化XMPPStream
-(void)setupXMPPStream{
    
    _xmppStream = [[XMPPStream alloc] init];
    
    //添加电子名片模块
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    _vCard = [[XMPPvCardTempModule alloc]initWithvCardStorage:_vCardStorage];
    //激活
    [_vCard activate:_xmppStream];
    
    //头像模块
    _avatar = [[XMPPvCardAvatarModule alloc]initWithvCardTempModule:_vCard];
    [_avatar activate:_xmppStream];
    
    // 设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

#pragma mark 连接到服务器
-(void)connectToHost
{
    NSLog(@"开始连接到服务器");
    if (!_xmppStream) {
        [self setupXMPPStream];
    }
    
    
    // 设置登录用户JID
    //resource 标识用户登录的客户端 iphone android
    NSString *user = nil;
    if (self.isRegisterOperation)
    {
        user = [UserInfo sharedUserInfo].registerUserName;
    }
    else
    {
        user = [UserInfo sharedUserInfo].user;
    }
    
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"10.82.23.65" resource:@"iPhone" ];
    _xmppStream.myJID = myJID;
    
    // 设置服务器域名
    _xmppStream.hostName = @"10.82.23.65";//不仅可以是域名，还可是IP地址
    
    // 设置端口 如果服务器端口是5222，可以省略
    _xmppStream.hostPort = 5222;
    
    // 连接
    NSError *err = nil;
    if(![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]){
        NSLog(@"%@",err);
    }
    
}


#pragma mark 连接到服务成功后，再发送密码授权
-(void)sendPwdToHost
{
    NSError *err = nil;
    NSString *password = [UserInfo sharedUserInfo].pwd;
    [_xmppStream authenticateWithPassword:password error:&err];
    
    if (err)
    {
        NSLog(@"%@",err);
    }
}

#pragma mark  授权成功后，发送"在线" 消息
-(void)sendOnlineToHost{
    
    NSLog(@"发送 在线 消息");
    XMPPPresence *presence = [XMPPPresence presence];
    
    [_xmppStream sendElement:presence];
    
    
}
#pragma mark -XMPPStream的代理
#pragma mark 与主机连接成功
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"与主机连接成功");
    
    if (self.isRegisterOperation)
    {
        NSString *pwd = [UserInfo sharedUserInfo].registerPwd;
        [_xmppStream registerWithPassword:pwd error:nil];
    }
    else
    {
        [self sendPwdToHost];
    }
}
#pragma mark  与主机断开连接
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    // 如果有错误，代表连接失败
    NSLog(@"与主机断开连接 %@",error);
    
    if(error && _resultBlock)
    {
        _resultBlock(XMPPResultTypeNetErr);
    }
    
}


#pragma mark 授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    [self sendOnlineToHost];
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginSuccess);
    }
}


#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    //判断block有无值，再回调给登陆控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
}

#pragma mark 注册成功
-(void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"注册成功");
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterSuccess);
    }
}
#pragma mark 注册失败
-(void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"注册失败%@",error);
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeRegisterFailure);
    }
}


#pragma mark -公共方法
-(void)userLogin:(XMPPResultBlock)resultBlock
{
    //先存储block
    _resultBlock = resultBlock;
    
    [_xmppStream disconnect];
    
    //连接到主机 发送授权密码
    [self connectToHost];
}

-(void)userRegister:(XMPPResultBlock)resultBlock
{
    //先存储block
    _resultBlock = resultBlock;
    
    [_xmppStream disconnect];
    
    //连接到主机 发送注册密码
    [self connectToHost];
}

-(void)userLogout
{
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
    
    [UserInfo sharedUserInfo].loginStatus = NO;
    [UserInfo sharedUserInfo].saveuserInfoToSanbox;
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    LoginController *viewController = [[LoginController alloc]init];
    MainNavigationController* loginViewController = [[MainNavigationController alloc]initWithRootViewController:viewController];

    window.rootViewController = loginViewController;
}



@end
