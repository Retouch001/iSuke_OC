//
//  RegisterFirstViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/26.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "RegisterFirstViewController.h"
#import "SelectCountryTableViewController.h"

@interface RegisterFirstViewController ()

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;


@property (weak, nonatomic) IBOutlet UITextField *iPhoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation RegisterFirstViewController

#pragma mark -- LifeCycle----
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.iPhoneTextField addTarget:self action:@selector(textFeildDidChanded:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark  - IBAction ---
- (IBAction)selectLocalAction:(id)sender {
    SelectCountryTableViewController *selectCountryVC = [[SelectCountryTableViewController alloc] init];
    @weakify(self);
    selectCountryVC.block = ^(NSString *countryName, NSString *countryCode) {
        @strongify(self);
        self.countryCodeLabel.text = countryCode;
        self.countryLabel.text = countryName;
    };
    
    RTRootNavigationController *rtNav = [[RTRootNavigationController alloc] initWithRootViewController:selectCountryVC];
    
    [self presentViewController:rtNav animated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate---
- (void)textFeildDidChanded:(UITextField *)textField{    
    if (textField.text.length > 0) {
        _nextBtn.backgroundColor = kColorTheme;
        _nextBtn.userInteractionEnabled = YES;
    }else{
        _nextBtn.backgroundColor = kColorUnClickBtnBg;
        _nextBtn.userInteractionEnabled = NO;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id secondRegisterVC = segue.destinationViewController;
    [secondRegisterVC setValue:_iPhoneTextField.text forKey:@"_phone"];
    [secondRegisterVC setValue:_countryCodeLabel.text forKey:@"_country_code"];
}

@end
