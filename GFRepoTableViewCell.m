//
//  GFRepoTableViewCell.m
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFRepoTableViewCell.h"

@implementation GFRepoTableViewCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self.photoImageView = [[UIImageView alloc]init];
    self.forkImageView = [[UIImageView alloc]init];
    self.starImageView = [[UIImageView alloc]init];

    self.byLabel = [[UILabel alloc]init];
    self.nameLabel = [[UILabel alloc]init];
    self.ownerLabel = [[UILabel alloc]init];
    self.starsLabel = [[UILabel alloc]init];
    self.forksLabel = [[UILabel alloc]init];
    self.descriptionLabel = [[UILabel alloc]init];

    self.titleView = [[UIView alloc]init];
    self.nameView  = [[UIView alloc]init];
    self.descriptionView = [[UIView alloc]init];
    self.starView = [[UIView alloc]init];
    self.forkView = [[UIView alloc]init];

    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [self.starView addSubview:self.starsLabel];
    [self.starView addSubview:self.starImageView];
    
    
    [self.forkView addSubview:self.forksLabel];
    [self.forkView addSubview:self.forkImageView];
    
    
    [self.titleView addSubview:self.nameLabel];
    [self.titleView addSubview:self.starView];
    [self.titleView addSubview:self.forkView];
    [[self contentView]addSubview:self.titleView];

    [self.nameView addSubview:self.ownerLabel];
    [self.nameView addSubview:self.byLabel];
    [[self contentView]addSubview:self.nameView];
    
    [self.descriptionView addSubview:self.descriptionLabel];
    [self.descriptionView addSubview:self.photoImageView];
    [[self contentView]addSubview:self.descriptionView];

    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    //3 main views first
    
    self.titleView.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.titleView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.titleView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor constant:5].active = YES;
    [self.titleView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;

    self.nameView.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.nameView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.nameView.bottomAnchor constraintEqualToAnchor:self.descriptionView.topAnchor constant:-3].active = YES;
    
    [self.nameView.heightAnchor constraintEqualToConstant:15].active = YES;

    self.descriptionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.descriptionView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.descriptionView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.descriptionView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.titleView.leadingAnchor].active = YES;
    [self.nameLabel.widthAnchor constraintGreaterThanOrEqualToConstant:70].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:self.titleView.bottomAnchor].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:self.titleView.topAnchor].active = YES;
    
    self.nameLabel.font = [UIFont fontWithName:@"Avenir-Book" size:13];
    self.nameLabel.textColor = [UIColor blackColor];
    
    self.starView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starView.leadingAnchor constraintEqualToAnchor:self.nameLabel.trailingAnchor constant:5].active = YES;
    [self.starView.bottomAnchor constraintEqualToAnchor:self.titleView.bottomAnchor].active = YES;
    [self.starView.topAnchor constraintEqualToAnchor:self.titleView.topAnchor].active = YES;
    
    
    self.forkView.translatesAutoresizingMaskIntoConstraints = false;
    [self.forkView.leadingAnchor constraintEqualToAnchor:self.starView.trailingAnchor].active = YES;
//    [self.forkView.trailingAnchor constraintEqualToAnchor:self.titleView.trailingAnchor].active = YES;
    [self.forkView.bottomAnchor constraintEqualToAnchor:self.titleView.bottomAnchor].active = YES;
    [self.forkView.topAnchor constraintEqualToAnchor:self.titleView.topAnchor].active = YES;
    
    
    
    //ugh forgot these constaints
    //within the starviews/fork views
    
    UILayoutGuide *starMargins = self.starView.layoutMarginsGuide;
    UILayoutGuide *forkMargins = self.forkView.layoutMarginsGuide;
    UILayoutGuide *descriptionMargins = self.descriptionView.layoutMarginsGuide;


    
    self.starImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView.widthAnchor constraintEqualToAnchor:self.starImageView.heightAnchor].active = YES;
    [self.starImageView.widthAnchor constraintEqualToConstant:17].active = YES;
    [self.starImageView.centerYAnchor constraintEqualToAnchor:starMargins.centerYAnchor].active = YES;
    [self.starImageView.leadingAnchor constraintEqualToAnchor:starMargins.leadingAnchor].active = YES;
    self.starImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.starImageView.image = [UIImage imageNamed:@"star"];
    
    self.starsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.starsLabel.leadingAnchor constraintEqualToAnchor:self.starImageView.trailingAnchor constant:2].active = YES;
    [self.starsLabel.trailingAnchor constraintEqualToAnchor:starMargins.trailingAnchor].active = YES;
    [self.starsLabel.centerYAnchor constraintEqualToAnchor:starMargins.centerYAnchor].active = YES;
    [self.starsLabel.bottomAnchor constraintEqualToAnchor:starMargins.bottomAnchor].active = YES;
    
    self.starsLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.starsLabel.textColor = [UIColor grayColor];
    
    self.forkImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.forkImageView.widthAnchor constraintEqualToAnchor:self.forkImageView.heightAnchor].active = YES;
    [self.forkImageView.widthAnchor constraintEqualToConstant:17].active = YES;
    [self.forkImageView.centerYAnchor constraintEqualToAnchor:forkMargins.centerYAnchor].active = YES;
    [self.forkImageView.leadingAnchor constraintEqualToAnchor:forkMargins.leadingAnchor].active = YES;
//    [self.forkImageView.trailingAnchor constraintEqualToAnchor:self.forksLabel.trailingAnchor].active = YES;
    self.forkImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.forkImageView.image = [UIImage imageNamed:@"fork"];
    
    self.forksLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.forksLabel.leadingAnchor constraintEqualToAnchor:self.forkImageView.trailingAnchor constant:2].active = YES;
//    [self.forksLabel.trailingAnchor constraintEqualToAnchor:forkMargins.trailingAnchor].active = YES;
    [self.forksLabel.centerYAnchor constraintEqualToAnchor:forkMargins.centerYAnchor].active = YES;
    [self.forksLabel.bottomAnchor constraintEqualToAnchor:forkMargins.bottomAnchor].active = YES;
    
    self.forksLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.forksLabel.textColor = [UIColor grayColor];

    
    
    
    self.byLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.byLabel.leadingAnchor constraintEqualToAnchor:self.nameView.leadingAnchor].active = YES;
    [self.byLabel.centerYAnchor constraintEqualToAnchor:self.nameView.centerYAnchor].active = YES;
    self.byLabel.text = @"by";
    
    self.byLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.byLabel.textColor = [UIColor grayColor];

    
    self.ownerLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.ownerLabel.leadingAnchor constraintEqualToAnchor:self.byLabel.trailingAnchor constant:5].active = YES;
    [self.ownerLabel.centerYAnchor constraintEqualToAnchor:self.nameView.centerYAnchor].active = YES;
    [self.ownerLabel.trailingAnchor constraintEqualToAnchor:self.nameView.trailingAnchor].active = YES;
    [self.ownerLabel.bottomAnchor constraintEqualToAnchor:self.nameView.bottomAnchor].active = YES;
    
    self.ownerLabel.font = [UIFont fontWithName:@"Avenir-Book" size:11];
    self.ownerLabel.textColor = [UIColor blackColor];
    
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToConstant:35].active = YES;
    [self.photoImageView.centerYAnchor constraintEqualToAnchor:self.descriptionView.centerYAnchor].active = YES;
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;

    
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor constant:10].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:descriptionMargins.trailingAnchor].active = YES;
    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:descriptionMargins.bottomAnchor].active = YES;
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:descriptionMargins.topAnchor].active = YES;
    
    [self.descriptionLabel sizeToFit];
    self.descriptionLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.descriptionLabel.textColor = [UIColor grayColor];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
//    self.titleView.backgroundColor = [UIColor yellowColor];
//    self.nameView.backgroundColor = [UIColor redColor];
//    self.descriptionView.backgroundColor = [UIColor greenColor];

}


@end
