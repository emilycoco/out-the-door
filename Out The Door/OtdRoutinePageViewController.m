//
//  OtdRoutinePageViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdRoutinePageViewController.h"

@implementation OtdRoutinePageViewController

- (void)viewDidLoad {
    UIImageView *newImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home"]];
    self.views = [[NSMutableArray alloc] init];
    [self.views addObject:newImage];

    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.views.count;
    self.scrollView.contentSize = CGSizeMake(375 * self.views.count, 757);
    [self.scrollView addSubview:newImage];
}

@end
