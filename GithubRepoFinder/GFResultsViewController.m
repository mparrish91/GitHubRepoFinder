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


@interface GFResultsViewController ()

@end

@implementation GFResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
     
     

@end
