//
//  UserInfo.m
//  WeChat
//
//  Created by LiDan on 15/10/7.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "UserInfo.h"

#define UserKey @"user"
#define PwdKey @"Password"
#define LoginKey @"LoginStatus"
#define AvatarKey @"AvatarImage"

@implementation UserInfo
singleton_implementation(UserInfo)

-(NSMutableArray *)addFriends
{
    if(!_addFriends)
    {
        _addFriends = [NSMutableArray array];
    }
    return _addFriends;
}

-(NSMutableArray *)msgRecordArray
{
    if (!_msgRecordArray)
    {
        _msgRecordArray = [NSMutableArray array];
    }
    return _msgRecordArray;
}

-(void)saveuserInfoToSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.loginStatus forKey:LoginKey];
    [defaults synchronize];
}

-(void)loadUserInfoFromSandBox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.loginStatus = [defaults boolForKey:LoginKey];
}


-(NSString *)JID
{
    return [NSString stringWithFormat:@"%@@%@",self.user,domain];
}

@end
