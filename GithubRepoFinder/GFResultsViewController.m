//
//  GFResultsViewController.m
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFResultsViewController.h"
#import "MBProgressHUD.h"
#import "GFRepo.h"
#import "GFRepoSearchSettings.h"
#import "GFRepoTableViewCell.h"
#import "GFRepo.h"
#import "UIImageView+AFNetworking.h"


@interface GFResultsViewController ()
@property(strong,readwrite,nonatomic) NSMutableArray *repos;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *reposTableView;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) UISearchBar *searchBar;

//@property(nonatomic,strong) GHErrorView *errorView;

@property (nonatomic, strong) NSMutableArray * filteredRepos;
@property (nonatomic, weak) NSArray * displayedItems;

//@property(nonatomic,strong) GFInfiniteScrollActivityView *loadingMoreView;


@end

@implementation GFResultsViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.reposTableView = [[UITableView alloc]init];
    self.searchBar = [[UISearchBar alloc] init];
    
//    self.errorView = [[GHErrorView alloc]init];
    self.repos = [[NSMutableArray alloc] init];
    self.filteredRepos = [[NSMutableArray alloc] init];
    
    
    
    self = [super init];
    if(self) {
    }
    return self;
}



//- (instancetype)initWithMovies:(NSArray *)movieArray
//{
//    self = [super init];
//    if(self) {
//        self.movies = movieArray;
//    }
//    return self;
//}

#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Flix";
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.7];
    
    //tableview
    NSString *cellIdentifier = @"cell";
    [self.reposTableView registerClass:[GFRepoTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    self.reposTableView.delegate = self;
    self.reposTableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.reposTableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
//    UIEdgeInsets insets = self.reposTableView.contentInset;
//    insets.bottom += FLInfiniteScrollActivityView.defaultHeight
//    self.moviesTableView.contentInset = insets;
    
    self.reposTableView.estimatedRowHeight = 100;
    self.reposTableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setConstraints];
    [self doSearch];
    
}


- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    GFRepoSearchSettings *searchSettings = [[GFRepoSearchSettings alloc]init];
    
    
    [GFRepo fetchReposWithSettings:searchSettings completion:^(NSArray *objects, NSError *error)
     {
         NSLog(@"%@", objects);
         
     }];
    
    
}


#pragma mark - TableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.displayedItems.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    GFRepoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier   forIndexPath:indexPath] ;
    
    if (cell == nil)
    {
        cell = [[GFRepoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    return cell;
}

//This function is where all the magic happens
-(void) tableView:(UITableView *) tableView willDisplayCell:(GFRepoTableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [UIView beginAnimations:@"fade" context:nil];
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount: 0.5];
    GFRepo *repo = [self.displayedItems objectAtIndex:indexPath.row];
    cell.titleLabel.text = [repo title];
    //    cell.overviewLabel.text = [self convertDateToString:movie.releaseDate];
    cell.overviewLabel.text = [repo overview];
    NSString *photoImageURL = [repo posterPath];
    
    
    [cell.photoImageView setImageWithURL:[NSURL URLWithString:photoImageURL] placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [UIView commitAnimations];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    GFRepo *repo = [self.displayedItems objectAtIndex:indexPath.row];

//    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithMovie:movie];
//    //    FLMovieDetailViewController *detailVC = [[FLMovieDetailViewController alloc]initWithURL:[movie posterPath]];
//    [self.navigationController pushViewController:detailVC animated:true];
}

- (void)refreshTable {
    [self doSearch];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    //Do your stuff here
    // You can also track the direction of UIScrollView here.
    
    if (!self.isMoreDataLoading)
    {
        CGFloat scrollViewContentHeight = self.reposTableView.contentSize.height;
        CGFloat scrollOffsetThreshold = scrollViewContentHeight - self.reposTableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.reposTableView.dragging) {
            self.isMoreDataLoading = true;
            
            CGRect frame = CGRectMake(0, self.reposTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.reposTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            [self fetchMovies];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.moviesTableView];
    [view addSubview:self.errorView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.moviesTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.moviesTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.moviesTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.moviesTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.moviesTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.errorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.errorView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.errorView.heightAnchor constraintEqualToConstant:30].active = YES;
    
}

- (void)hideErrorView:(FLErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = true;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)showErrorView:(FLErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = false;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)setupInfiniteScrollView
{
    CGRect frame = CGRectMake(0, self.moviesTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.moviesTableView.bounds.size.width, FLInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[FLInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.moviesTableView addSubview:self.loadingMoreView];
    self.loadingMoreView.backgroundColor = [UIColor yellowColor];
    
    
}

-(void)addSearchBar {
    
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    
    self.navigationItem.titleView = self.searchBar;
    
    
    
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [self setupInfiniteScrollView];
    [self addSearchBar];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.moviesTableView setContentOffset:CGPointMake(0, 0)];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.moviesTableView setContentOffset:CGPointMake(0, 0)];
    
}



@end
