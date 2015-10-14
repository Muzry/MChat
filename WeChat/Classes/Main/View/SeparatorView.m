//
//  SeparatorView.m
//  WeChat
//
//  Created by LiDan on 15/10/14.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "SeparatorView.h"

@implementation SeparatorView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = SelfColor(200, 199, 204);
        self.width = frame.size.width;
        self.height = frame.size.height;
        self.x = frame.origin.x;
        self.y = frame.origin.y;
    }
    return self;
}

//-(void)setupYFromCell:(UITableViewCell *)cell X:(CGFloat)x
//{
//    self.x = x;
//    self.y = cell.height;
//}

@end
