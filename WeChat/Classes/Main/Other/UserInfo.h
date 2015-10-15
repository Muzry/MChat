//
//  UserInfo.h
//  WeChat
//
//  Created by LiDan on 15/10/7.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface UserInfo : NSObject

singleton_interface(UserInfo);

/**账户名*/
@property (nonatomic,copy)NSString *user;

/**密码*/
@property (nonatomic,copy)NSString *pwd;

/**注册账号名*/
@property (nonatomic,copy)NSString *registerUserName;

/**注册密码*/
@property (nonatomic,copy)NSString *registerPwd;

/**登陆状态*/
@property (nonatomic,assign) BOOL loginStatus;

/**Jid*/
@property (nonatomic,copy)NSString *JID;

@property (nonatomic,strong) NSMutableArray *addFriends;


-(void)loadUserInfoFromSandBox;
-(void)saveuserInfoToSanbox;

@end
