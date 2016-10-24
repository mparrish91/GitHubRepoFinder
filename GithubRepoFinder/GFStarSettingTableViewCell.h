//
//  GFStarSettingTableViewCell.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GFStarSettingTableViewCellDelegate;


@interface GFStarSettingTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *filterLabel;
@property(strong,readwrite,nonatomic) UILabel *starsLabel;
@property(strong,readwrite,nonatomic) UISlider *starSlider;

@property(weak,nonatomic) id <GFStarSettingTableViewCellDelegate> delegate;


@end




@protocol GFStarSettingTableViewCellDelegate <NSObject>
@optional
- (void)gfStarSettingLabelDidChange:(GFStarSettingTableViewCell *)cell value: (BOOL)value;

@end


