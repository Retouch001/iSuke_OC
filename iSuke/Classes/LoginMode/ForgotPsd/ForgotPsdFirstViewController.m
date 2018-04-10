//
//  ForgotPsdFirstViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/8.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "ForgotPsdFirstViewController.h"
#import "SelectCountryTableViewController.h"

@interface ForgotPsdFirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *countryName;
@property (weak, nonatomic) IBOutlet UILabel *countryCode;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@end

@implementation ForgotPsdFirstViewController

#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_phoneTextField addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}



#pragma mark -IBAction--
- (IBAction)selectCountryAction:(id)sender {
    SelectCountryTableViewController *selectCountryVC = [[SelectCountryTableViewController alloc] init];
    @weakify(self);
    selectCountryVC.block = ^(NSString *countryName, NSString *countryCode) {
        @strongify(self);
        self.countryCode.text = countryCode;
        self.countryName.text = countryName;
    };
    
    RTRootNavigationController *rtNav = [[RTRootNavigationController alloc] initWithRootViewController:selectCountryVC];
    [self presentViewController:rtNav animated:YES completion:nil];
}



#pragma mark - UITextFieldDidChanged---
- (void)textFieldDidChanged:(UITextField *)textField{
    if (_phoneTextField.text.length > 0) {
        _nextBtn.backgroundColor = kColorTheme;
        _nextBtn.userInteractionEnabled = YES;
    }else{
        _nextBtn.backgroundColor = kColorUnClickBtnBg;
        _nextBtn.userInteractionEnabled = NO;
    }
}




#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    id secondForgotVC = segue.destinationViewController;
    [secondForgotVC setValue:_phoneTextField.text forKey:@"_phone"];
    [secondForgotVC setValue:_countryCode.text forKey:@"_country_code"];
}


@end
