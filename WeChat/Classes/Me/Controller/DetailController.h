//
//  DetailController.h
//  WeChat
//
//  Created by LiDan on 15/10/11.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailControllerDelegate <NSObject>

-(void)didUpdateInfo;

@end

@interface DetailController : UITableViewController
@property (nonatomic,weak) id<DetailControllerDelegate> delegate;
@end
