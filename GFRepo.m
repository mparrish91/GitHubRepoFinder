//
//  GFRepo.m
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import "GFRepo.h"
#import "GFRepoSearchSettings.h"
#import "AFNetworking.h"


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
        valuesForKeys[@"stars"] = value;
    
    if ((value = dict[@"forks_count"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"forks"] = value;
    
    if ((value = dict[@"description"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"repoDescription"] = value;
    
    if ((value = dict[@"owner"]) && [value isKindOfClass:[NSString class]])
        valuesForKeys[@"ownerHandle"] = value[@"login"];
        valuesForKeys[@"ownerAvatarURL"] = value[@"avatar_url"];

    [self setValuesForKeysWithDictionary:valuesForKeys];
    
    return self;
}


+ (void)fetchReposWithSettings:(GFRepoSearchSettings *)settings completion: (void (^)(NSArray *objects, NSError *error))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSArray *params = [self queryParamsWithSettings:settings];
    NSLog(@"%@", reposUrl);

    [manager GET:reposUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"finished 1");
        
        NSMutableArray *repos = [[NSMutableArray alloc]init];
        
        if (responseObject) {
            NSArray *results = responseObject[@"items"];
            
            for (NSDictionary *result in results) {
                GFRepo *object = [[GFRepo alloc] initWithServerRepresentation:result];
                if (object != nil)
                {
                    [repos addObject:object];
                }
                
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed 1 - error = %@", error.localizedDescription);

    }];
    
    
}


+ (NSArray *)queryParamsWithSettings:(GFRepoSearchSettings *)settings
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if (clientID != @"") {
        params[@"client_id"] = clientID;
    }
    
    if (clientSecret != @"") {
        params[@"client_secret"] = clientSecret;
    }
    
    NSString *q = @"";
    if (settings.searchString != nil) {
          q = [q stringByAppendingString:settings.searchString];
    }
 
    q = [q stringByAppendingString:[NSString stringWithFormat:@"stars:>%d", settings.minStars]];
    params[@"q"] = q;
    params[@"sort"] = @"stars";
    params[@"order"] = @"desc";

    return params;
    

    
}





- (NSString *)description {
    NSString *descriptionString = [NSString stringWithFormat:@"Name: %@; Stars: %f;Forks: %f;Owner: %@;Avatar: %@;Description: %@;", self.name, self.stars, self.forks, self.ownerHandle, self.ownerAvatarURL, self.repoDescription];
    return descriptionString;
    
}





@end
