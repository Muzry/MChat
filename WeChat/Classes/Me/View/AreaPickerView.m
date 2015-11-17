//
//  AreaPickerView.m
//  WeChat
//
//  Created by LiDan on 15/11/17.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong) NSDictionary *areaDict;
@property (nonatomic,strong) NSDictionary *cityDict;
@property (nonatomic,strong) NSArray *areaArray;

@end

@implementation AreaPickerView

-(NSDictionary *)areaDict
{
    if (!_areaDict)
    {
        _areaDict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"]];
    }
    return _areaDict;
}



-(instancetype)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.areaDict.count;
    }
    else if (component == 1)
    {
        return self.cityDict.count;
    }
    else
    {
        return self.areaArray.count;
    }
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        return self.areaDict[[NSString stringWithFormat:@"%ld",(long)row]];
    }
    else if (component == 1)
    {
        return self.cityDict[[NSString stringWithFormat:@"%ld",(long)row]];
    }
    else
    {
        return self.areaArray[row];
    }
}

@end
