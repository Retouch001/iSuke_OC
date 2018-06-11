//
//  SelectCountryTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/3/28.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SelectCountryTableViewController.h"
#import "SearchResultCountryTableViewController.h"

static NSString *const reuseIdentifier = @"Cell";

@interface SelectCountryTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSDictionary *countryDictionary;
@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, strong) NSArray *countryArray;

@property (nonatomic, strong) NSArray *searchList;
@end

@implementation SelectCountryTableViewController
#pragma mark -LifeCycle--
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = RTLocalizedString(@"选择地区");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RTLocalizedString(@"取消") style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelect)];

    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.backgroundColor = kColorBase;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //NSString *plistPathCH = [[NSBundle mainBundle] pathForResource:@"sortedChnames" ofType:@"plist"];
    NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedEnames" ofType:@"plist"];
    
    self.countryDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPathEN];
    self.indexArray = [[NSArray alloc] initWithArray:[[self.countryDictionary allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<self.indexArray.count; i++) {
        NSArray *array = [self.countryDictionary objectForKey:self.indexArray[i]];
        [tempArray addObjectsFromArray:array];
    }
    self.countryArray = tempArray;
}

- (void)cancelSelect{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.searchController.active) {
        return 1;
    }
    return [self.countryDictionary allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.searchList.count;
    }
    NSArray *array = [self.countryDictionary objectForKey:[self.indexArray objectAtIndex:section]];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.searchController.active) {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
        cell.textLabel.text = [[self.countryDictionary objectForKey:[self.indexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    }
    return cell;
}

//-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    return self.indexArray;
//}

//-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    if (self.searchController.active) {
//        return ;
//    }
//    return index;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 30;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.searchController.active) {
        return @"";
    }
    return [self.indexArray objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        NSString *string = self.searchList[indexPath.row];
        NSArray *stringArray = [string componentsSeparatedByString:@"+"];
        self.block(stringArray.firstObject, [NSString stringWithFormat:@"+%@",stringArray.lastObject]);
        self.searchController.active = NO;
    }else{
        NSString *string = [[self.countryDictionary objectForKey:[self.indexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        NSArray *stringArray = [string componentsSeparatedByString:@"+"];
        self.block(stringArray.firstObject, [NSString stringWithFormat:@"+%@",stringArray.lastObject]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -UISearchResultsUpdating---
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = searchController.searchBar.text;
    if (searchText.length <= 0){
        self.searchList = [NSMutableArray array];
        [self.tableView reloadData];
        return;
    }
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS[cd] '%@'",strippedString]];
    NSArray *array = [self.countryArray filteredArrayUsingPredicate:predicate];
    if (array.count > 0 ) {
        self.searchList = array;
        [self.tableView reloadData];
    }else{
        self.searchList = [NSMutableArray array];
        [self.tableView reloadData];
    }
}




#pragma mark ---SetterGetter---
-(UISearchController *)searchController{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        [_searchController.searchBar sizeToFit];
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        [_searchController.searchBar setBackgroundImage:[UIImage new]];
        [_searchController.searchBar setValue:RTLocalizedString(@"取消") forKey:@"_cancelButtonText"];
        _searchController.searchBar.tintColor = kColorTheme;
        _searchController.searchBar.placeholder = RTLocalizedString(@"搜索");
        self.definesPresentationContext = YES;
    }
    return _searchController;
}


@end
