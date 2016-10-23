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
    
    [self.forkImageView addSubview:self.forksLabel];
    [self.forkImageView addSubview:self.forkImageView];
    
    
    [self.titleView addSubview:self.nameLabel];
    [self.titleView addSubview:self.starView];
    [self.titleView addSubview:self.forkImageView];
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
    
    self.titleView.translatesAutoresizingMaskIntoConstraints = false;
    [self.titleView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.titleView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.titleView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.titleView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;

    self.nameView.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.nameView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.nameView.bottomAnchor constraintEqualToAnchor:self.descriptionView.topAnchor].active = YES;

    
    self.descriptionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.descriptionView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.descriptionView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.descriptionView.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    
    
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.nameLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.nameLabel.widthAnchor constraintGreaterThanOrEqualToConstant:100].active = YES;
    [self.nameLabel.trailingAnchor constraintEqualToAnchor:self.starView.leadingAnchor].active = YES;
    [self.nameLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.nameLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    self.starView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.starView.trailingAnchor constraintEqualToAnchor:self.forkView.leadingAnchor].active = YES;
    [self.starView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.starView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    
    self.forkView.translatesAutoresizingMaskIntoConstraints = false;
    [self.forkView.leadingAnchor constraintEqualToAnchor:self.starView.trailingAnchor].active = YES;
    [self.forkView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.forkView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.forkView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    
    
    //ugh forgot these constaints
    //within the starviews/fork views
    
    UILayoutGuide *starMargins = self.starView.layoutMarginsGuide;
    UILayoutGuide *forkMargins = self.forkView.layoutMarginsGuide;


    
    self.starImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;
    [self.starImageView.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.starImageView.centerYAnchor constraintEqualToAnchor:starMargins.centerYAnchor].active = YES;
    [self.starImageView.leadingAnchor constraintEqualToAnchor:self.starView.trailingAnchor].active = YES;
    [self.starImageView.trailingAnchor constraintEqualToAnchor:self.starsLabel.trailingAnchor].active = YES;
    self.starImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.forkImageView.image = [UIImage imageNamed:@"star"];
    
    self.starsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.starsLabel.leadingAnchor constraintEqualToAnchor:self.starImageView.trailingAnchor].active = YES;
    [self.starsLabel.trailingAnchor constraintEqualToAnchor:starMargins.trailingAnchor].active = YES;
    [self.starsLabel.centerYAnchor constraintEqualToAnchor:starMargins.centerYAnchor].active = YES;
    [self.starsLabel.bottomAnchor constraintEqualToAnchor:starMargins.bottomAnchor].active = YES;
    
    self.forkImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.forkImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;
    [self.forkImageView.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.forkImageView.centerYAnchor constraintEqualToAnchor:forkMargins.centerYAnchor].active = YES;
    [self.forkImageView.leadingAnchor constraintEqualToAnchor:forkMargins.leadingAnchor].active = YES;
    [self.forkImageView.trailingAnchor constraintEqualToAnchor:self.forksLabel.trailingAnchor].active = YES;
    self.forkImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.forkImageView.image = [UIImage imageNamed:@"fork"];
    
    self.forksLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.forksLabel.leadingAnchor constraintEqualToAnchor:self.forkImageView.trailingAnchor].active = YES;
    [self.forksLabel.trailingAnchor constraintEqualToAnchor:forkMargins.trailingAnchor].active = YES;
    [self.forksLabel.centerYAnchor constraintEqualToAnchor:forkMargins.centerYAnchor].active = YES;
    [self.forksLabel.bottomAnchor constraintEqualToAnchor:forkMargins.bottomAnchor].active = YES;
    
    
    
    
    self.byLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.byLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.forksLabel.centerYAnchor constraintEqualToAnchor:self.nameView.centerYAnchor].active = YES;
    [self.byLabel.trailingAnchor constraintEqualToAnchor:self.ownerLabel.leadingAnchor].active = YES;
    
    self.ownerLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.ownerLabel.centerYAnchor constraintEqualToAnchor:self.nameView.centerYAnchor].active = YES;
    [self.ownerLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.ownerLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.widthAnchor constraintEqualToAnchor:self.photoImageView.heightAnchor].active = YES;
    [self.photoImageView.widthAnchor constraintEqualToConstant:80].active = YES;
    [self.photoImageView.centerYAnchor constraintEqualToAnchor:self.descriptionView.centerYAnchor].active = YES;

    [self.photoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.photoImageView.trailingAnchor constraintEqualToAnchor:self.descriptionLabel.leadingAnchor].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;

    
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.photoImageView.trailingAnchor].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.descriptionView.topAnchor].active = YES;
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    [self.descriptionLabel sizeToFit];
    self.descriptionLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.descriptionLabel.textColor = [UIColor grayColor];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}


@end