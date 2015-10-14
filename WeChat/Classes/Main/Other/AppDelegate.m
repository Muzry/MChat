//
//  AppDelegate.m
//  WeChat
//
//  Created by LiDan on 15/10/3.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginController.h"
#import "MainNavigationController.h"
#import "MainTabBarController.h"


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",path);
    
    
    [[UserInfo sharedUserInfo] loadUserInfoFromSandBox];
    [self switchController];
    return YES;
}

#pragma mark 切换控制器
-(void)switchController
{
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    [MainNavigationController setupNavTheme];
    
    if([UserInfo sharedUserInfo].loginStatus)
    {
        
        MainTabBarController *tabBarController = [[MainTabBarController alloc]init];
        self.window.rootViewController  = tabBarController;
        [[XmppTools sharedXmppTools] userLogin:nil];
    }
    else
    {
        LoginController *viewController = [[LoginController alloc]init];
        
        MainNavigationController* loginViewController = [[MainNavigationController alloc]initWithRootViewController:viewController];
        self.window.rootViewController = loginViewController;
    }
    
    [self.window makeKeyAndVisible];
}
@end
