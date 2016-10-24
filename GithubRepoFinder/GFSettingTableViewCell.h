//
//  GFSettingTableViewCell.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GFSettingTableViewCellDelegate;


@interface GFSettingTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *filterLabel;
@property(strong,readwrite,nonatomic) UISwitch *filterSwitch;

@property(weak,nonatomic) id <GFSettingTableViewCellDelegate> delegate;


@end




@protocol GFSettingTableViewCellDelegate <NSObject>
@optional
- (void)gfSettingCellSwitchDidChange:(GFSettingTableViewCell *)cell value: (BOOL)value;

@end

