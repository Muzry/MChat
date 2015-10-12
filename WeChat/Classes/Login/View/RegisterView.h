//
//  OtherWayLogin.h
//  WeChat
//
//  Created by LiDan on 15/10/7.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisterViewDelegate <NSObject>
/**
 *  完成注册
 */
-(void)registerViewDidFinishRegister;

@end

@interface RegisterView : UIView

@property (nonatomic,weak) id<RegisterViewDelegate> delegate;

@end
