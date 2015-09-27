//
//  OtdAddTasksViewController.h
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OtdAddTasksDelegate

- (void)addTasks:(NSMutableArray *)tasks;

@end

@interface OtdAddTasksViewController : UIViewController

@property (weak, nonatomic) id delegate;

@end
