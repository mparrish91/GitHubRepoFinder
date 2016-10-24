//
//  GFSettingsViewController.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YPFilterTableViewCell.h"
@protocol YPFiltersViewControllerDelegate;


@interface GFSettingsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, YPFilterTableViewCellDelegate>

@property(weak,nonatomic) id <YPFiltersViewControllerDelegate> delegate;

@end



@protocol YPFiltersViewControllerDelegate <NSObject>
@optional
- (void)ypFiltersViewControllerDidUpdateFilters:(YPFilterViewController *)filtersViewController filters:(NSDictionary *)filters;

@end

