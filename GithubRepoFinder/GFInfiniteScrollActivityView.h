//
//  GFInfiniteScrollActivityView.h
//  GithubRepoFinder
//
//  Created by parry on 10/22/16.
//  Copyright © 2016 parry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GFInfiniteScrollActivityView : UIView


+ (CGFloat)defaultHeight;

- (void)startAnimating;
- (void)stopAnimating;

@end
