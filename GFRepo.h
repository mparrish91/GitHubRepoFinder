//
//  GFRepo.h
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GFRepo : NSObject

- (instancetype)initWithServerRepresentation:(NSDictionary *)dict;

@property(strong,readonly,nonatomic) NSString *name;
@property(strong,readonly,nonatomic) NSString *ownerHandle;
@property(strong,readonly,nonatomic) NSString *ownerAvatarURL;

@property(readonly,nonatomic) NSInteger *stars;
@property(readonly,nonatomic) NSInteger *forks;
@property(strong,readonly,nonatomic) NSString *repoDescription;



@end
