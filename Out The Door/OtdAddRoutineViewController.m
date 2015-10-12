//
//  addRoutineViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/16/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdAddRoutineViewController.h"

@interface OtdAddRoutineViewController()

@property (strong, nonatomic) OtdRoutineModel *routineModel;

@property (weak, nonatomic) IBOutlet UITextField *routineNameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *routineDestinationTextfield;

@property (weak, nonatomic) IBOutlet UIDatePicker *routineDestinationTimeTextfield;


@property (weak, nonatomic) IBOutlet UITextField *routineRouteTimeTextfield;

@end

@implementation OtdAddRoutineViewController

- (void)viewDidLoad {
    self.routineModel = [[OtdRoutineModel alloc] init];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addLocation:(OtdLocationModel *)location {
    self.routineModel.location = location;
}

- (void)addTasks:(NSMutableArray *)tasks {
    self.routineModel.routineTasks = tasks;
    self.routineModel.alarmTime = self.routineModel.otdTime = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMinute
                                                                                                       value:-60
                                                                                                      toDate:[NSDate date]
                                                                                                     options:0];
}

- (void)saveInitialData {
    self.routineModel.name = self.routineNameTextfield.text;
    self.routineModel.destinationName = self.routineDestinationTextfield.text;
    self.routineModel.timeToDestination = [self.routineRouteTimeTextfield.text doubleValue];
    self.routineModel.arriveToDestination = self.routineDestinationTimeTextfield.date;
    self.routineModel.alarmTime = nil;
    self.routineModel.daysToUse = 0;
    self.routineModel.otdTime = [NSDate date];
    self.routineModel.location = nil;
    self.routineModel.routineTasks = [[NSMutableArray alloc] init];
    [[OtdDataInterface sharedInstance] saveRoutine:self.routineModel completion:^(BOOL success, PFObject *Routine, NSError *error) {
        self.routineModel.objectId = Routine.objectId;
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self saveInitialData];
    if ([segue.identifier isEqualToString:@"addTasks"]) {
        OtdAddTasksViewController *vc =segue.destinationViewController;
        vc.routineModel = self.routineModel;
    }
}

//- (void)saveRoutineData {
//    self.routineModel.name = self.routineNameTextfield.text;
//    self.routineModel.destinationName = self.routineDestinationTextfield.text;
//    self.routineModel.timeToDestination = [self.routineRouteTimeTextfield.text doubleValue];
//    self.routineModel.arriveToDestination = self.routineDestinationTimeTextfield.date;
//    self.routineModel.daysToUse = 0;
//    self.routineModel.otdTime = [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitMinute
//                                                                         value:-60
//                                                                        toDate:[NSDate date]
//                                                                       options:0];
//}

@end
