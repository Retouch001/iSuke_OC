//
//  SelectSceneConditionView.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/20.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SelectSceneConditionView.h"

@interface SelectSceneConditionView ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *_dataArray;
    NSArray *_subDataArray;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, copy) void (^cancelBlock)(void);                              // 取消回调
@property (nonatomic, copy) void (^okBlock)(NSArray *array);                       // 确定回调


@property (nonatomic, strong) NSString *selectNumber;
@property (nonatomic, strong) NSString *subSelectNumber;
@end

@implementation SelectSceneConditionView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}


- (IBAction)okBtnClick:(id)sender {
    NSArray *array;
    if (self.subSelectNumber) {
        array = @[self.selectNumber,self.subSelectNumber];
    }else{
        array = @[self.selectNumber];
    }
    !self.okBlock?:self.okBlock(array);
    [self bgBtnClick:nil];
}

- (IBAction)cancelBtnClick:(id)sender {
    !self.cancelBlock ? : self.cancelBlock();
    [self bgBtnClick:nil];
}

- (IBAction)bgBtnClick:(id)sender {
    [UIView animateWithDuration:.25f animations:^{
        self.bottomConstraint.constant = - (216 + 40);
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showWithDataArray:(NSArray *)dataArray subDataArray:(NSArray *)subDataArray cancel:(void (^)(void))cancel ok:(void (^)(NSArray *))ok{
    _dataArray = dataArray;
    _subDataArray = subDataArray;
    
    self.selectNumber = _dataArray.firstObject;
    self.subSelectNumber = _subDataArray.firstObject;
    
    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
    self.cancelBlock = cancel;
    self.okBlock = ok;
    
    self.frame = [UIScreen mainScreen].bounds;
    self.bottomConstraint.constant = - (216 + 40);
    [self layoutIfNeeded];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.25f animations:^{
        self.bottomConstraint.constant = 0.f;
        [self layoutIfNeeded];
    }];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
}


#pragma mark <UIPickerViewDelegate>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (_subDataArray.count > 0) {
        return 2;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _dataArray.count;
    }
    return _subDataArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 70.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 45;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectNumber = _dataArray[row];
    }else{
        self.subSelectNumber = _subDataArray[row];
    }
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
            myView.text = _dataArray[row];
            break;
        case 1:
            myView.text = _subDataArray[row];
            break;
        default:
            break;
    }
    myView.textColor = UIColor.blackColor;
    myView.font = [UIFont systemFontOfSize:24]; // 用label来设置字体大小
    myView.backgroundColor = [UIColor clearColor];
    return myView;
    
    

}

@end
