//
//  QQViewController.h
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController

@property(nonatomic,weak) NSString *nickName;
@property(nonatomic,weak) XMPPJID *Jid;

@end
