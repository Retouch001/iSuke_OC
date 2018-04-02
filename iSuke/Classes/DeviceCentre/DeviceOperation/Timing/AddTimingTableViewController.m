//
//  AddTimingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddTimingTableViewController.h"

static const NSInteger pickerDataSize = 160000;

@interface AddTimingTableViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minutes;

@end

@implementation AddTimingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = self.tableView.backgroundColor;
    
    self.hours = [NSMutableArray array];
    self.minutes = [NSMutableArray array];
    for (int i = 1; i < 25; i++) {
        [self.hours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 0; i < 60; i ++) {
        NSString *string = [NSString stringWithFormat:@"%d",i];
        if (string.length == 1) {
            string = [@"0" stringByAppendingString:string];
        }
        [self.minutes addObject:string];
    }
    
    [self.pickerView selectRow:pickerDataSize/2 inComponent:0 animated:false];
    [self.pickerView selectRow:pickerDataSize/2 inComponent:1 animated:NO];
    
}

- (IBAction)leftBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rightBtnClick:(id)sender {
}






#pragma mark UIPickerView DataSource Method 数据源方法
//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = pickerDataSize;//根据数组的元素个数返回几行数据
            break;
        case 1:
            result = pickerDataSize;
            break;
            
        default:
            break;
    }
    
    return result;
}

#pragma mark UIPickerView Delegate Method 代理方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
}


//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = self.hours[row % self.hours.count];
            break;
        case 1:
            title = self.minutes[row % self.minutes.count];
            break;
        default:
            break;
    }
    return title;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    // 设置列的宽度
    return 50.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    // 设置列中的每行的高度
    return 40.0;
}



@end
