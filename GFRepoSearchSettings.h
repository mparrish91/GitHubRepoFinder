//
//  GFRepoSearchSettings.h
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFRepoSearchSettings : NSObject

@property(strong,readonly,nonatomic) NSString *searchString;
@property(readonly,nonatomic) NSInteger *minStars;


@end
