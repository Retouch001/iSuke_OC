//
//  TimeZoneSelectTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimeZoneSelectTableViewController.h"
#import "TimeZoneTableViewCell.h"

static NSString *const reuseIdentifier = @"Cell";
@interface TimeZoneSelectTableViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *timeZoneArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation TimeZoneSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    self.timeZoneArray = [NSTimeZone knownTimeZoneNames];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TimeZoneTableViewCell class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];

//    // 获取所有已知的时区名称
//    NSArray *zoneNames = [NSTimeZone knownTimeZoneNames];
//    for (NSString *string in zoneNames) {
//        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:string];
//        NSLog(@"时区:%@\n时区名:%@\n时区缩写:%@",timeZone,string,timeZone.abbreviation);
//    }
//
//    NSLog(@"%@",[NSTimeZone abbreviationDictionary]);
    

}



- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeZoneArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimeZoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell freshCellWithString:self.timeZoneArray[indexPath.row]];
    return cell;
}





#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}






#pragma mark  -SetterGetter----
-(UISearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        [_searchController.searchBar sizeToFit];
        _searchController.dimsBackgroundDuringPresentation = YES;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
        [_searchController.searchBar setValue:RTLocalizedString(@"取消") forKey:@"_cancelButtonText"];
        _searchController.searchBar.tintColor = kColorTheme;
        _searchController.searchBar.placeholder = RTLocalizedString(@"搜索时区");

        self.definesPresentationContext = YES;
    }
    return _searchController;
}



@end
