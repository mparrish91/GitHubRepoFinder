//
//  GFSettingsViewController.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFSettingTableViewCell.h"
#import "GFStarSettingTableViewCell.h"


@protocol GFSettingsViewControllerDelegate;


@interface GFSettingsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(weak,nonatomic) id <GFSettingsViewControllerDelegate> delegate;

@end



@protocol GFSettingsViewControllerDelegate <NSObject>
@optional
- (void)gfSettingsViewControllerDidUpdateFilters:(GFSettingsViewController *)filtersViewController searchString:(NSString *)searchString;

@end

