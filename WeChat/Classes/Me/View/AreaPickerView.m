//
//  AreaPickerView.m
//  WeChat
//
//  Created by LiDan on 15/11/17.
//  Copyright © 2015年 com.lidan. All rights reserved.
//

#import "AreaPickerView.h"

@interface AreaPickerView() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;

@end

@implementation AreaPickerView

-(NSString *)resultSting
{
    if (!_resultSting)
    {
        _resultSting = [[NSString alloc]init];
    }
    return _resultSting;
}

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        [self getPickerData];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)getPickerData
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:0]];
    
    if (self.selectedArray.count > 0)
    {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    if (self.cityArray.count > 0)
    {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
    {
        return self.provinceArray.count;
    }
    else if (component == 1)
    {
        return self.cityArray.count;
    }
    else
    {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0)
    {
        return [self.provinceArray objectAtIndex:row];
    }
    else if (component == 1)
    {
        return [self.cityArray objectAtIndex:row];
    }
    else
    {
        return [self.townArray objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0)
        {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        }
        else
        {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0)
        {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        }
        else
        {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1)
    {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0)
        {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        }
        else
        {
            self.townArray = nil;
        }
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    self.resultSting = [NSString stringWithFormat:@"%@ %@ %@",
                        [self.provinceArray objectAtIndex:[self selectedRowInComponent:0]],
                        [self.cityArray objectAtIndex:[self selectedRowInComponent:1]],
                        [self.townArray objectAtIndex:[self selectedRowInComponent:2]]];
    [pickerView reloadComponent:2];
}

@end
