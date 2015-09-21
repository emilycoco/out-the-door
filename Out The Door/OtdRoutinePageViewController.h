//
//  OtdRoutinePageViewController.h
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtdAddTasksViewController.h"
#import "OtdAddRoutineViewController.h"

@interface OtdRoutinePageViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSMutableArray *views;

@end
