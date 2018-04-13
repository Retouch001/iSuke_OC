//
//  AddShareUserFirstViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/10.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "AddShareUserFirstViewController.h"
#import "DeviceCentreModel.h"

@interface AddShareUserFirstViewController (){
    Device *_device;
}

@property (weak, nonatomic) IBOutlet UIImageView *deviceIcon;
@property (weak, nonatomic) IBOutlet UILabel *deviceName;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@end

@implementation AddShareUserFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_phoneTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}


- (IBAction)addAction:(id)sender {
}




- (void)textFieldDidChanged:(UITextField *)textField{
    if (_phoneTextField.text.length > 0 ) {
        _addBtn.backgroundColor = kColorTheme;
        _addBtn.userInteractionEnabled = YES;
    }else{
        _addBtn.backgroundColor = kColorUnClickBtnBg;
        _addBtn.userInteractionEnabled = NO;
    }
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id vc = segue.destinationViewController;
    [vc setValue:_phoneTextField.text forKey:@"_phone"];
    [vc setValue:_device forKey:@"_device"];
}


@end
