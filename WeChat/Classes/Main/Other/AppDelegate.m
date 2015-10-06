//
//  AppDelegate.m
//  WeChat
//
//  Created by LiDan on 15/10/3.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "AppDelegate.h"
#import "XMPPFramework.h"
#import "LoginController.h"
#import "MainNavigationController.h"
#import "MainTabBarController.h"

@interface AppDelegate ()<XMPPStreamDelegate>
{
    XMPPStream *_xmppStream;
    XMPPResultBlock _resultBlock;
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

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    UIViewController *viewController = [[UIViewController alloc]init];
    viewController.title = @"登陆";
    
    LoginController* loginViewController = [[LoginController alloc]initWithRootViewController:viewController];
    self.window.rootViewController = loginViewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark  -私有方法
#pragma mark 初始化XMPPStream
-(void)setupXMPPStream{
    
    _xmppStream = [[XMPPStream alloc] init];
    
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
    
    //从沙盒获取用户名
    NSString *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"User"];
    XMPPJID *myJID = [XMPPJID jidWithUser:user domain:@"muzry.local" resource:@"iPhone" ];
    _xmppStream.myJID = myJID;
    
    // 设置服务器域名
    _xmppStream.hostName = @"muzry.local";//不仅可以是域名，还可是IP地址
    
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
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"Password"];
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
    
    // 主机连接成功后，发送密码进行授权
    [self sendPwdToHost];
}
#pragma mark  与主机断开连接
-(void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    // 如果有错误，代表连接失败
    NSLog(@"与主机断开连接 %@",error);
    
}


#pragma mark 授权成功
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功");
    [self sendOnlineToHost];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //来到主界面
        MainTabBarController *tabBarController = [[MainTabBarController alloc]init];
        [self.window.rootViewController presentViewController:tabBarController animated:YES completion:nil];
//        self.window.rootViewController = tabBarController;
    });
}


#pragma mark 授权失败
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    //判断block有无值，再回调给登陆控制器
    if (_resultBlock) {
        _resultBlock(XMPPResultTypeLoginFailure);
    }
}


#pragma mark -公共方法
-(void)userLogin:(XMPPResultBlock)resultBlock
{
    //先存储block
    _resultBlock = resultBlock;
    
    //连接到主机
    [self connectToHost];
}

-(void)logout
{
    // 1." 发送 "离线" 消息"
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppStream sendElement:offline];
    
    // 2. 与服务器断开连接
    [_xmppStream disconnect];
}
@end
