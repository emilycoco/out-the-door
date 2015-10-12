//
//  OtdAddTasksViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdAddTasksViewController.h"

@implementation OtdAddTasksViewController

- (void)saveTasks {
    self.routineModel.routineTasks = [[NSMutableArray alloc] initWithObjects:@"test", @"testTwo", @"testThree", nil];
    [[OtdDataInterface sharedInstance] saveRoutine:self.routineModel completion:^(BOOL success, PFObject *Routine, NSError *error) {

    }];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self saveTasks];
    if ([segue.identifier  isEqualToString:@"chooseLocation"]) {
        OtdChooseLocationViewController *vc =segue.destinationViewController;
        vc.routineModel = self.routineModel;
    }
}

@end
