//
//  QQTableView.h
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageToolsView.h"
@interface MessageTableView : UITableView
@property(nonatomic,weak) XMPPJID *Jid;
@end
