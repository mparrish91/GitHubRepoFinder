//
//  GFSettingsViewController.m
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFSettingsViewController.h"
#import "GFSettingTableViewCell.h"
#import "GFStarSettingTableViewCell.h"
#import "GFFilterSettingTableViewCell.h"


@interface GFSettingsViewController ()

@property(strong,readwrite,nonatomic) NSArray *categories;


@property(nonatomic,strong) UITableView *filtersTableView;

@property (nonatomic, strong) NSMutableArray * filteredBusinesses;
@property (nonatomic, strong) NSArray * displayedItems;
@property (nonatomic, strong) NSMutableDictionary * switchStates;
@property (nonatomic, strong) NSArray * filters;
@property (nonatomic, strong) NSArray * distance;
@property (nonatomic, strong) NSArray * sort;
@property (nonatomic, strong) NSArray * languages;



@end

@implementation GFSettingsViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.filtersTableView = [[UITableView alloc]init];
    self.switchStates = [[NSMutableDictionary alloc]init];

    self.languages = @[ @"Java", @"JavaScript",@"Objective-C",@"Python", @"Ruby", @"Swift"];

    
    
    if (!(self = [super init]))
        return nil;
    
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Filter";
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"  style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButtonTapped)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"  style:UIBarButtonItemStylePlain target:self action:@selector(onSaveButtonTapped)];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.filtersTableView registerClass:[GFSettingTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.filtersTableView registerClass:[GFStarSettingTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.filtersTableView registerClass:[GFFilterSettingTableViewCell class] forCellReuseIdentifier:cellIdentifier];

    self.filtersTableView.delegate = self;
    self.filtersTableView.dataSource = self;
    
    [self setConstraints];
    
}



#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0)
    {
        return 1;
        
    }
    
    if (section == 1)
    {
        return self.languages.count + 1;
        
    }
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    if (indexPath.section == 0)
    {
        GFStarSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
        return cell;
    }
    
    if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            GFSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
            return cell;
        }
        else {
            GFFilterSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
            return cell;
        }
    }
       UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    

    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(UITableView *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        cell.filterLabel.text = self.filters[0];
        
    }
    
    if (indexPath.section == 1)
    {
        cell.filterLabel.text = self.distance[indexPath.row];
    }
    if (indexPath.section == 2)
    {
        cell.filterLabel.text = self.sort[indexPath.row];
    }
    
    if (indexPath.section == 3)
    {
        NSDictionary *categoryName = [self.categories objectAtIndex:indexPath.row];
        cell.filterLabel.text = categoryName[@"name"];
    }
    
    
    cell.delegate = self;
    NSString *convertedIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (self.switchStates[convertedIndexPath] != nil)
    {
        cell.filterSwitch.on = self.switchStates[convertedIndexPath];
        
    }
    else{
        cell.filterSwitch.on = false;
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    //    Business *business = [self.displayedItems objectAtIndex:indexPath.row];
    
    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
    //    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
    //    [self.navigationController pushViewController:detailVC animated:true];
}



- (void)ypFilterCellSwitchDidChange:(YPFilterTableViewCell *)cell value: (BOOL)value;
{
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:cell];
    
    NSLog(@"filters got the switch event");
    NSString *convertedIndexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    self.switchStates[convertedIndexPath] = [NSNumber numberWithBool:value];
    NSLog(@"filters got the switch event");
    
}


- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.filtersTableView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.filtersTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.filtersTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.filtersTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.filtersTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.filtersTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    
}


-(void)onCancelButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)onSaveButtonTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *filters = [[NSMutableDictionary alloc]init];
    NSMutableArray *selectedCategories = [[NSMutableArray alloc]init];
    
    for (NSString *row in self.switchStates) {
        NSNumber *state = [self.switchStates objectForKey: row];
        if ([state  isEqualToNumber: [NSNumber numberWithInt:1]])
        {
            NSDictionary *category = self.categories[[row integerValue]];
            NSString *code = category[@"code"];
            [selectedCategories addObject:code];
        }
    }
    
    if (selectedCategories.count > 0)
    {
        filters[@"categories"] = selectedCategories;
    }
    
    if ([self.delegate respondsToSelector:@selector(ypFiltersViewControllerDidUpdateFilters:filters:)]) {
        [self.delegate ypFiltersViewControllerDidUpdateFilters:self filters:filters];
    }
    
}


@end
