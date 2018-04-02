//
//  TimeZoneSelectTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "TimeZoneSelectTableViewController.h"


static NSString *const reuseIdentifier = @"Cell";
@interface TimeZoneSelectTableViewController ()<UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *timeZoneArray;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation TimeZoneSelectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeZoneArray = [NSTimeZone knownTimeZoneNames];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.tableView.tableHeaderView = self.searchController.searchBar;

}







#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.timeZoneArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.timeZoneArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}





#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}






#pragma mark  -SetterGetter----
-(UISearchController *)searchController{
    if (_searchController == nil) {
        // 创建搜索框
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        [_searchController.searchBar sizeToFit];
        
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
        self.definesPresentationContext = YES;
    }
    return _searchController;
}



@end
