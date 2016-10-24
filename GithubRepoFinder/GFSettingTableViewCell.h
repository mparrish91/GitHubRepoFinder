//
//  GFSettingTableViewCell.h
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YPFilterTableViewCellDelegate;


@interface GFSettingTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *filterLabel;
@property(strong,readwrite,nonatomic) UILabel *starsLabel;
@property(strong,readwrite,nonatomic) UISlider *starSlider;

@property(weak,nonatomic) id <YPFilterTableViewCellDelegate> delegate;


@end




@protocol YPFilterTableViewCellDelegate <NSObject>
@optional
- (void)ypFilterCellSwitchDidChange:(YPFilterTableViewCell *)cell value: (BOOL)value;

@end

