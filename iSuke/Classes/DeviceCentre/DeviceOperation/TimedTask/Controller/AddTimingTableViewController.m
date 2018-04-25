//
//  AddTimingTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/30.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddTimingTableViewController.h"
#import "WeekSelectTableViewController.h"

#import "AddTimedTaskApi.h"
#import "EditTimedTaskApi.h"

#import <DateTools/DateTools.h>

static const NSInteger pickerDataSize = 160000;

@interface AddTimingTableViewController ()<RTRequestDelegate>{
    Device *_device;
    TimedTask *_timedTask;
    
    AddTimedTaskApi *addTimedTaskApi;
    EditTimedTaskApi *editTimedTaskApi;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *selectedWeeksLabel;
@property (weak, nonatomic) IBOutlet UILabel *timedTaskActionLabel;

@property (nonatomic, strong) NSMutableArray *hours;
@property (nonatomic, strong) NSMutableArray *minutes;
@end

@implementation AddTimingTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = self.tableView.backgroundColor;
    self.title = self.timedTaskVCType == RTTimedTaskVCTypeAdd?RTLocalizedString(@"添加定时"):RTLocalizedString(@"编辑定时");
    
    [self initData];
    [self freshUI];
}


#pragma mark -IBAction--
- (IBAction)leftBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)rightBtnClick:(id)sender {
    [SVProgressHUD showWithStatus:RTLocalizedString(@"请稍后")];
    if (self.timedTaskVCType == RTTimedTaskVCTypeAdd) {
        addTimedTaskApi = [[AddTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id device:_device timedTask:_timedTask];
        addTimedTaskApi.delegate = self;
        [addTimedTaskApi start];
    }else{
        editTimedTaskApi = [[EditTimedTaskApi alloc] initWithApp_user_id:[MainUserManager getLocalMainUserInfo].app_user_id timedTask:_timedTask];
        editTimedTaskApi.delegate = self;
        [editTimedTaskApi start];
    }
}


#pragma mark -UITableViewDelegate--
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"开启设备") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_timedTask.timedtask_action = 1;
            [self freshUI];
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"关闭设备") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self->_timedTask.timedtask_action = 0;
            [self freshUI];
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:RTLocalizedString(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}


#pragma mark UIPickerView DataSource Method 数据源方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;//第一个展示字母、第二个展示数字
}

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
    NSInteger hourRows = [self.pickerView selectedRowInComponent:0];
    NSInteger minuteRows = [self.pickerView selectedRowInComponent:1];
    NSString *hour = self.hours[hourRows % self.hours.count];
    if (hour.length == 1) {
        hour = [@"0" stringByAppendingString:hour];
    }
    NSString *minute = self.minutes[minuteRows % self.minutes.count];
    _timedTask.timedtask_time = [NSString stringWithFormat:@"%@%@",hour,minute];    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews){
        if (singleLine.frame.size.height < 1){
            singleLine.backgroundColor = kColorPickerCuttingLine;
        }
    }
    UILabel *myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 40)];
    myView.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
            myView.text = self.hours[row % self.hours.count];
            break;
        case 1:
            myView.text = self.minutes[row % self.minutes.count];
            break;
        default:
            break;
    }
    myView.textColor = UIColor.blackColor;
    myView.font = [UIFont systemFontOfSize:24]; // 用label来设置字体大小
    myView.backgroundColor = [UIColor clearColor];
    return myView;
}



- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 50.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.0;
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    [SVProgressHUD dismiss];
    if ([request dataSuccess]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [SVProgressHUD showErrorWithStatus:request.errorMessage];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma PrivateMethod--
- (void)freshUI{
    self.selectedWeeksLabel.text = [self parseTimedTaskDays:_timedTask.timedtask_days];
    self.timedTaskActionLabel.text = _timedTask.timedtask_action?RTLocalizedString(@"开启设备"):RTLocalizedString(@"关闭设备");
    
    NSInteger hour = [[_timedTask.timedtask_time substringToIndex:2] integerValue];
    NSInteger minute = [[_timedTask.timedtask_time substringFromIndex:2] integerValue];
    [self.pickerView selectRow:(hour-1) + 24*100 inComponent:0 animated:NO];
    [self.pickerView selectRow:minute + 60*100 inComponent:1 animated:NO];
}

- (void)initData{
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
    
    if (self.timedTaskVCType == RTTimedTaskVCTypeAdd) {
        _timedTask = [[TimedTask alloc] init];
        _timedTask.timedtask_time = [[NSDate date] formattedDateWithFormat:@"HHmm"];
        _timedTask.timedtask_days = @"1,2,3,4,5,6,7";
    }
}


- (NSString *)parseTimedTaskDays:(NSString *)timedTaskDays{
    NSArray *weekDays = [timedTaskDays componentsSeparatedByString:@","];
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < weekDays.count; i++) {
        NSString *temp = weekDays[i];
        if (i == 0) {
            if ([temp isEqualToString:@"1"]) {
                [string appendString:RTLocalizedString(@"周一")];
            }else if ([temp isEqualToString:@"2"]){
                [string appendString:RTLocalizedString(@"周二")];
            }else if ([temp isEqualToString:@"3"]){
                [string appendString:RTLocalizedString(@"周三")];
            }else if ([temp isEqualToString:@"4"]){
                [string appendString:RTLocalizedString(@"周四")];
            }else if ([temp isEqualToString:@"5"]){
                [string appendString:RTLocalizedString(@"周五")];
            }else if ([temp isEqualToString:@"6"]){
                [string appendString:RTLocalizedString(@"周六")];
            }else{
                [string appendString:RTLocalizedString(@"周日")];
            }
        }else{
            if ([temp isEqualToString:@"1"]) {
                [string appendString:RTLocalizedString(@" 周一")];
            }else if ([temp isEqualToString:@"2"]){
                [string appendString:RTLocalizedString(@" 周二")];
            }else if ([temp isEqualToString:@"3"]){
                [string appendString:RTLocalizedString(@" 周三")];
            }else if ([temp isEqualToString:@"4"]){
                [string appendString:RTLocalizedString(@" 周四")];
            }else if ([temp isEqualToString:@"5"]){
                [string appendString:RTLocalizedString(@" 周五")];
            }else if ([temp isEqualToString:@"6"]){
                [string appendString:RTLocalizedString(@" 周六")];
            }else{
                [string appendString:RTLocalizedString(@" 周日")];
            }
        }
    }
    return string;
}

- (NSString *)parseTimedTaskTime:(NSString *)timedTaskTime{
    return [NSString stringWithFormat:@"%@:%@",[timedTaskTime substringToIndex:2],[timedTaskTime substringFromIndex:2]];
}



#pragma mark -UINavigate---
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationController *nav = segue.destinationViewController;
    WeekSelectTableViewController *selectWeekVC = nav.viewControllers.firstObject;
    
    NSArray *array = [_timedTask.timedtask_days componentsSeparatedByString:@","];
    [selectWeekVC setValue:array forKey:@"_selectedWeeks"];
    //@weakify(self);
    selectWeekVC.block = ^(NSString *selectedWeeks) {
        //@strongify(self);
        self->_timedTask.timedtask_days = selectedWeeks;
        [self freshUI];
    };
}



@end
