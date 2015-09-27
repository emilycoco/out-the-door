//
//  OtdAddTasksViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdAddTasksViewController.h"

@implementation OtdAddTasksViewController

- (IBAction)nextStep:(id)sender {
    NSMutableArray *taskInfo = [[NSMutableArray alloc] initWithObjects:@"test", @"testTwo", @"testThree", nil];
    [self.delegate addTasks:taskInfo];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
