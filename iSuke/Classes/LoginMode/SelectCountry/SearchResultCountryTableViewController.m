//
//  SearchResultCountryTableViewController.m
//  iSuke
//
//  Created by Tang Retouch on 2018/4/27.
//  Copyright © 2018年 Tang Retouch. All rights reserved.
//

#import "SearchResultCountryTableViewController.h"

static NSString *const reuseIdentifier = @"Cell";


@interface SearchResultCountryTableViewController ()
@property (nonatomic, strong) NSArray *countryArray;
@property (nonatomic, strong) NSArray *searchArray;

@end

@implementation SearchResultCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = kColorTableViewSeparatorLine;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    NSString *plistPathEN = [[NSBundle mainBundle] pathForResource:@"sortedEnames" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPathEN];
    NSArray *indexArray = [[NSArray alloc] initWithArray:[[dic allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }]];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<indexArray.count; i++) {
        NSArray *array = [dic objectForKey:indexArray[i]];
        [tempArray addObjectsFromArray:array];
    }
    self.countryArray = tempArray;
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.searchArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -UISearchResultsUpdating---
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchText = searchController.searchBar.text;
    if (searchText.length <= 0){
        self.searchArray = [NSMutableArray array];
        [self.tableView reloadData];
        return;
    }
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF CONTAINS[cd] '%@'",strippedString]];
    NSArray *array = [self.countryArray filteredArrayUsingPredicate:predicate];
    if (array.count > 0 ) {
        self.searchArray = array;
        [self.tableView reloadData];
    }else{
        self.searchArray = [NSMutableArray array];
        [self.tableView reloadData];
    }
}





@end
