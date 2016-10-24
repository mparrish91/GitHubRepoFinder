//
//  GFFilterSettingTableViewCell.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GFFilterSettingTableViewCellDelegate;


@interface GFFilterSettingTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *filterLabel;
@property(strong,readwrite,nonatomic) UISwitch *filterSwitch;

@property(weak,nonatomic) id <GFFilterSettingTableViewCellDelegate> delegate;


@end




@protocol GFFilterSettingTableViewCellDelegate <NSObject>
@optional
- (void)gfFilterSettingSwitchDidChange:(GFFilterSettingTableViewCell *)cell value: (BOOL)value;

@end

