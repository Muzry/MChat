//
//  MainTabBarController.m
//  WeChat
//
//  Created by LiDan on 15/10/4.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "MainViewController.h"
#import "ContactController.h"
#import "MeController.h"
#import "DiscoverController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *mainVc = [[MainViewController alloc]init];
    [self addOneChildVc:mainVc title:@"微信" imageName:@"tabbar_mainframe" selectedImageName:@"tabbar_mainframeHL"];
    ContactController *contactVc = [[ContactController alloc]init];
    [self addOneChildVc:contactVc title:@"通讯录" imageName:@"tabbar_contacts" selectedImageName:@"tabbar_contactsHL"];
    DiscoverController *discoverVc = [[DiscoverController alloc]init];
    [self addOneChildVc:discoverVc title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discoverHL"];
    MeController *meVc = [[MeController alloc]init];
    [self addOneChildVc:meVc title:@"我" imageName:@"tabbar_me" selectedImageName:@"tabbar_meHL"];
    [self.tabBar setTintColor:SelfColor(9, 187, 7)];
}

- (void) addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *) selectedImageName
{
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    MainNavigationController *nav = [[MainNavigationController alloc]initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
