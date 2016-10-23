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
#import "GFInfiniteScrollActivityView.h"
#import "GFErrorView.h"


@interface GFResultsViewController ()
@property(strong,readwrite,nonatomic) NSMutableArray *repos;
@property (nonatomic,assign) BOOL isMoreDataLoading;


@property(nonatomic,strong) UITableView *reposTableView;
@property(nonatomic,strong) UIRefreshControl *refreshControl;
@property(nonatomic,strong) UISearchBar *searchBar;

@property(nonatomic,strong) GFErrorView *errorView;

@property (nonatomic, strong) NSMutableArray * filteredRepos;
@property (nonatomic, weak) NSArray * displayedItems;

@property(nonatomic,strong) GFInfiniteScrollActivityView *loadingMoreView;


@end

@implementation GFResultsViewController


#pragma mark - Initialize

- (instancetype)init
{
    self.reposTableView = [[UITableView alloc]init];
    self.searchBar = [[UISearchBar alloc] init];
    
    self.errorView = [[GFErrorView alloc]init];
    self.repos = [[NSMutableArray alloc] init];
    self.filteredRepos = [[NSMutableArray alloc] init];
    

    if (!(self = [super init]))
        return nil;
    
    
    return self;
}




#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings"  style:UIBarButtonItemStylePlain target:self action:@selector(refreshTable)];

    [self setConstraints];
    [self doSearch];
    
}


- (void)doSearch {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    GFRepoSearchSettings *searchSettings = [[GFRepoSearchSettings alloc]init];
    
    
    [GFRepo fetchReposWithSettings:searchSettings completion:^(NSArray *objects, NSError *error)
     {
         if (error)
         {
             [self showErrorView:self.errorView];
         }
         else
         {
             [self hideErrorView:self.errorView];
             
         }
         [self.repos addObjectsFromArray:objects];
         self.displayedItems = self.repos;
         
    
         dispatch_async(dispatch_get_main_queue(), ^{
             self.isMoreDataLoading = false;
             [self.reposTableView reloadData];

             
             
             if ([[NSThread currentThread] isMainThread]){
                 NSLog(@"In main thread--completion handler");
                 [self.refreshControl endRefreshing];
                 [self.loadingMoreView stopAnimating];
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 
                 
             }
             else{
                 NSLog(@"Not in main thread--completion handler");
             }
             
         });

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
    

    GFRepo *repo = [self.displayedItems objectAtIndex:indexPath.row];
    cell.nameLabel.text = [repo name];
    cell.ownerLabel.text = [repo ownerHandle];
    cell.starsLabel.text = [NSString stringWithFormat:@"%li", (long)[repo stars].integerValue];
    cell.forksLabel.text = [NSString stringWithFormat:@"%li", (long)[repo forks].integerValue];
    cell.descriptionLabel.text = [repo repoDescription];

    NSString *photoImageURL = [repo ownerAvatarURL];
    
    
    [cell.photoImageView setImageWithURL:[NSURL URLWithString:photoImageURL] placeholderImage:[UIImage imageNamed:@"placeholder-background"]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
            
            CGRect frame = CGRectMake(0, self.reposTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.reposTableView.bounds.size.width, GFInfiniteScrollActivityView.defaultHeight);
            self.loadingMoreView.frame = frame;
            [self.loadingMoreView startAnimating];
            
            [self doSearch];
            
        }
    }
    
}



- (void)loadView
{
    [super loadView];
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = view;
    [view addSubview:self.reposTableView];
    [view addSubview:self.errorView];
    
}


-(void)setConstraints
{
    
    UIView *view= self.view;
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    
    
    self.reposTableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.reposTableView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.reposTableView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.reposTableView.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
    [self.reposTableView.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    self.errorView.translatesAutoresizingMaskIntoConstraints = false;
    [self.errorView.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
    [self.errorView.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
    [self.errorView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    [self.errorView.heightAnchor constraintEqualToConstant:30].active = YES;
    
}

- (void)hideErrorView:(GFErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = true;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)showErrorView:(GFErrorView *)errorView
{
    [UIView animateWithDuration:1.0 delay:0.0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0 options:0 animations:^{
        
        errorView.hidden = false;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)setupInfiniteScrollView
{
    CGRect frame = CGRectMake(0, self.reposTableView.contentSize.height - self.tabBarController.tabBar.frame.size.height, self.reposTableView.bounds.size.width, GFInfiniteScrollActivityView.defaultHeight);
    self.loadingMoreView = [[GFInfiniteScrollActivityView alloc]initWithFrame:frame];
    self.loadingMoreView.hidden = true;
    [self.reposTableView addSubview:self.loadingMoreView];
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
    [self.reposTableView setContentOffset:CGPointMake(0, 0)];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.reposTableView setContentOffset:CGPointMake(0, 0)];
    
}



@end
