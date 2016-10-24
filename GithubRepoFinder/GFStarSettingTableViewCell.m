//
//  GFStarSettingTableViewCell.m
//  GithubRepoFinder
//
//  Created by parry on 10/24/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFStarSettingTableViewCell.h"


@implementation GFStarSettingTableViewCell

#pragma mark - Initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    self.filterLabel  = [[UILabel alloc]init];
    self.starsLabel = [[UILabel alloc]init];
    self.starSlider = [[UISlider alloc]init];
    
    
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
        return nil;
    
    [[self contentView]addSubview:self.filterLabel];
    [[self contentView]addSubview:self.starSlider];
    [[self contentView]addSubview:self.starsLabel];
    
    [self.starSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    
    
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    
    UILayoutGuide *margins = self.contentView.layoutMarginsGuide;
    
    self.filterLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.filterLabel.leadingAnchor constraintEqualToAnchor:margins.leadingAnchor].active = YES;
    [self.filterLabel.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    self.filterLabel.font = [UIFont fontWithName:@"Avenir-Book" size:14];
    self.filterLabel.text = @"Minimum Stars";

    
    self.starSlider.translatesAutoresizingMaskIntoConstraints = false;
    [self.starSlider.centerXAnchor constraintEqualToAnchor:margins.centerXAnchor].active = YES;
    [self.starSlider.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    [self.starSlider.leadingAnchor constraintEqualToAnchor:self.filterLabel.trailingAnchor constant:20].active = YES;
    [self.starSlider.trailingAnchor constraintEqualToAnchor:self.starsLabel.leadingAnchor].active = YES;
    
    self.starSlider.minimumValue = 0.0;
    self.starSlider.maximumValue = 1000.0;
    self.starSlider.continuous = YES;
    self.starSlider.value = 25.0;
    
    
    self.starsLabel.translatesAutoresizingMaskIntoConstraints = false;
    [self.starsLabel.trailingAnchor constraintEqualToAnchor:margins.trailingAnchor].active = YES;
    [self.starsLabel.centerYAnchor constraintEqualToAnchor:margins.centerYAnchor].active = YES;
    self.starsLabel.text = @"0";

    
    
}

-(void)sliderAction:(id)sender
{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    NSString *strValue = [NSString stringWithFormat:@"%.3f", value];
    self.starsLabel.text = strValue;

    //-- Do further actions
    
    NSLog(@"switch pressed bro");
    if ([self.delegate respondsToSelector:@selector(gfStarSettingLabelDidChange:value:)]) {
        [self.delegate gfStarSettingLabelDidChange:self value:self.starsLabel.text];
    }
}


@end
