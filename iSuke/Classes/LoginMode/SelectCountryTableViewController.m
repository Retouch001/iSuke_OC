//
//  SelectCountryTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SelectCountryTableViewController.h"

static NSString *const reuseIdentifier = @"Cell";

@interface SelectCountryTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSDictionary *countryDictionary;
@property (nonatomic, strong) NSArray *indexArray;


@end

@implementation SelectCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = RTLocalizedString(@"选择地区");
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.backgroundColor = kColorBase;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedChnames" ofType:@"plist"];
    //NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedEnames" ofType:@"plist"];
    
    self.countryDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPathCH];
    self.indexArray = [[NSArray alloc] initWithArray:[[self.countryDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.countryDictionary allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = [self.countryDictionary objectForKey:[self.indexArray objectAtIndex:section]];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.countryDictionary objectForKey:[self.indexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];

    // Configure the cell...
    
    return cell;
}



-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.indexArray;
}
//
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 30;
    
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.indexArray objectAtIndex:section];
}




- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}




#pragma mark ---SetterGetter---
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
