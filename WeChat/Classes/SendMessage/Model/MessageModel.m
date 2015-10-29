//
//  QQMessageModel.m
//  QQ
//
//  Created by LiDan on 15/9/16.
//  Copyright (c) 2015年 LiDan. All rights reserved.
//

#import "MessageModel.h"
@implementation MessageModel


-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)messageWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
