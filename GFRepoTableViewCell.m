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
    
    self.starsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.starsLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.starsLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.starsLabel.bottomAnchor constraintEqualToAnchor:margins.bottomAnchor].active = YES;
    
    self.starImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.starImageView.leadingAnchor constraintEqualToAnchor:self.starView.trailingAnchor].active = YES;
    [self.starImageView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.starImageView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.starImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.starImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.forkImageView.image = [UIImage imageNamed:@"star"];

    
    self.forksLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.forksLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.forksLabel.widthAnchor constraintGreaterThanOrEqualToConstant:100].active = YES;
    [self.forksLabel.trailingAnchor constraintEqualToAnchor:self.starView.leadingAnchor].active = YES;
    [self.forksLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.forksLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    self.forkImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.forkImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.forkImageView.trailingAnchor constraintEqualToAnchor:self.forkView.leadingAnchor].active = YES;
    [self.forkImageView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.forkImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.forkImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.forkImageView.image = [UIImage imageNamed:@"fork"];
    

    
    
    
    
    
    
    
    
    
    self.byLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.byLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.byLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.byLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.byLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    self.ownerLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.ownerLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.ownerLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.ownerLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.ownerLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = false;
    [self.photoImageView.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.photoImageView.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.photoImageView.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.photoImageView.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    self.photoImageView.contentMode = UIViewContentModeScaleAspectFit;


    
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.descriptionLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.nameView.topAnchor].active = YES;
    [self.descriptionLabel.topAnchor constraintEqualToAnchor:margins.topAnchor].active = YES;
    
    [self.descriptionLabel sizeToFit];
    
    self.descriptionLabel.font = [UIFont fontWithName:@"Avenir-Book" size:9];
    self.descriptionLabel.textColor = [UIColor grayColor];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}


@end
