//
//  SelectCityTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/5/22.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SelectCityTableViewController.h"
#import "GetCitiesApi.h"
#import "CityModel.h"

static NSString *const reuseIdentifier = @"Cell";

@interface SelectCityTableViewController ()<UISearchResultsUpdating,RTRequestDelegate>{
    GetCitiesApi *getCitiesApi;
}
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *searchList;
@property (nonatomic, strong) CityModel *cityModel;
@end

@implementation SelectCityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = RTLocalizedString(@"选择城市");
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:RTLocalizedString(@"取消") style:UIBarButtonItemStylePlain target:self action:@selector(cancelSelect)];
    
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.backgroundColor = kColorBase;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    getCitiesApi = [[GetCitiesApi alloc] init];
    getCitiesApi.delegate = self;
    [getCitiesApi start];
}

- (void)cancelSelect{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -RTRequestDelegate--
- (void)requestFinished:(__kindof RTBaseRequest *)request{
    if ([request dataSuccess]) {
        self.cityModel = [CityModel modelWithDictionary:request.responseObject];
        [self.tableView reloadData];
    }
}

- (void)requestFailed:(__kindof RTBaseRequest *)request{
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active) {
        return self.searchList.count;
    }
    return self.cityModel.sceneCondition.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (self.searchController.active) {
        cell.textLabel.text = self.searchList[indexPath.row];
    }else{
        City *city = self.cityModel.sceneCondition[indexPath.row];
        cell.textLabel.text = city.city_cn;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.searchController.active) {
//        NSString *string = self.searchList[indexPath.row];
//        NSArray *stringArray = [string componentsSeparatedByString:@"+"];
//        self.block(stringArray.firstObject, [NSString stringWithFormat:@"+%@",stringArray.lastObject]);
//        self.searchController.active = NO;
//    }else{
//        NSString *string = [[self.countryDictionary objectForKey:[self.indexArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
//        NSArray *stringArray = [string componentsSeparatedByString:@"+"];
//        self.block(stringArray.firstObject, [NSString stringWithFormat:@"+%@",stringArray.lastObject]);
//    }
//    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -UISearchResultsUpdating---
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    NSString *searchText = searchController.searchBar.text;
//    if (searchText.length <= 0){
//        self.searchList = [NSMutableArray array];
//        [self.tableView reloadData];
//        return;
//    }
//    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS[cd] '%@'",strippedString]];
//    NSArray *array = [self.countryArray filteredArrayUsingPredicate:predicate];
//    if (array.count > 0 ) {
//        self.searchList = array;
//        [self.tableView reloadData];
//    }else{
//        self.searchList = [NSMutableArray array];
//        [self.tableView reloadData];
//    }
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
