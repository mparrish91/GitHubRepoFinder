//
//  GFRepo.m
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFRepo.h"
#import "UIImageView+AFNetworking.h"
#import "GFRepoSearchSettings.h"


#define reposUrl @"https://api.github.com/search/repositories"
#define clientID @""
#define clientSecret @""


@implementation GFRepo


- (instancetype)initWithServerRepresentation:(NSDictionary *)dict
{
    
    NSMutableDictionary *valuesForKeys = [NSMutableDictionary dictionary];
    id value = nil;
    
    
    if ((value = dict[@"name"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"name"] = value;
    
    if ((value = dict[@"stargazers_count"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"overview"] = value;
    
    if ((value = dict[@"forks_count"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"releaseDate"] = value;
    
    if ((value = dict[@"description"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"title"] = value;
    
    if ((value = dict[@"owner"]) && [value respondsToSelector:@selector(doubleValue)])
        valuesForKeys[@"login"] = value;
        valuesForKeys[@"avatar_url"] = value;

    [self setValuesForKeysWithDictionary:valuesForKeys];
    
    return self;
}




+ (void)fetchReposWithCompletionHandler:(void (^)(NSArray *objects, NSError *error))completionHandler
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    NSArray *params = [self ]
    
    [manager GET:reposUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}


- (NSArray *)queryParamsWithSettins:(GFRepoSearchSettings *)settings
{
    NSMutableArray *params = [[NSMutableArray alloc]init];
    if clientID != nil {
        self.params["client_id"] = self.clientID
    }
    
    if clientSecret != nil {
        self.params["client_secret"] = self.clientSecret
    }
    
    NSString *q = @""
    if settings.searchString != nil {
        q = [myString stringByAppendingString:settings.searchSettings];

    }
    q = [myString stringByAppendingString:settings.searchSettings];
    params[@"q"] = q;
    params[@"sort"] = @"starts";
    params[@"order"] = @"desc";

    return params;
    

    
}





- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Name: %@; Stars: %f;Forks: %f;Owner: %@;Avatar: %@;Description: %@;", self.name, self.stars, self.forks, self.ownerHandle, self.ownerAvatarURL, self.repoDescription];
    return descriptionString;
    
}





@end
