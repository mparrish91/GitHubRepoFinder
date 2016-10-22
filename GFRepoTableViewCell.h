//
//  GFRepoTableViewCell.h
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFRepoTableViewCell : UITableViewCell

@property(strong,readwrite,nonatomic) UILabel *nameLabel;
@property(strong,readwrite,nonatomic) UILabel *ownerLabel;
@property(strong,readwrite,nonatomic) UILabel *starsLabel;
@property(strong,readwrite,nonatomic) UILabel *byLabel;

@property(strong,readwrite,nonatomic) UILabel *forksLabel;
@property(strong,readwrite,nonatomic) UILabel *descriptionLabel;

@property(strong,readwrite,nonatomic) UIImageView *photoImageView;
@property(strong,readwrite,nonatomic) UIImageView *forkImageView;
@property(strong,readwrite,nonatomic) UIImageView *starImageView;



@property(strong,readwrite,nonatomic) UIView *titleView;
@property(strong,readwrite,nonatomic) UIView *nameView;
@property(strong,readwrite,nonatomic) UIView *descriptionView;

@property(strong,readwrite,nonatomic) UIView *starView;
@property(strong,readwrite,nonatomic) UIView *forkView;


@end
