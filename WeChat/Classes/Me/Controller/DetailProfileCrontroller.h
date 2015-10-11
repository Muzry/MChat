//
//  DetailProfileCrontroller.h
//  WeChat
//
//  Created by LiDan on 15/10/11.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DetailProfileCrontrollerDelegate <NSObject>

-(void)didFinishSave;

@end

@interface DetailProfileCrontroller : UITableViewController

@property (nonatomic,strong) UITableViewCell *cell;
@property (nonatomic,weak) id<DetailProfileCrontrollerDelegate> delegate;

@end
