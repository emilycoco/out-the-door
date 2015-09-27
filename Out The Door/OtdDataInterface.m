//
//  dataInterface.m
//  Out The Door
//
//  Created by Emily Coco on 9/19/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdDataInterface.h"
#import <Parse/Parse.h>

@implementation OtdDataInterface

+(OtdDataInterface *) sharedInstance {
    static OtdDataInterface *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });

    return sharedInstance;
}

- (id)init {
    self = [super init];
    return self;
}

-(void)addLocation:(OtdLocationModel *)locationModel completion:(void(^)(BOOL success, NSError *error))completionBlock {
    PFObject *Location = [PFObject objectWithClassName:@"Location"];
    PFGeoPoint *locationPoint = [PFGeoPoint geoPointWithLatitude:locationModel.location.latitude longitude:locationModel.location.longitude];
    Location[@"name"] = locationModel.name;
    Location[@"location"] = locationPoint;
    Location[@"radius"] = @(locationModel.radius);
    [Location saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            completionBlock(YES, error);
        } else {
            completionBlock(NO, error);
        }
    }];
}

-(void)getAllLocations:(void(^)(NSArray *locations, NSError *error))completionBlock {
    PFQuery *locationQuery = [PFQuery queryWithClassName:@"Location"];
    [locationQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            completionBlock(objects, error);
    }];

}

-(void)addRoutine:(OtdRoutineModel *)routineModel completion:(void (^)(BOOL, NSError *))completionBlock {
    PFObject *Routine = [PFObject objectWithClassName:@"Routine"];
//    PFGeoPoint *locationPoint = [PFGeoPoint geoPointWithLatitude:routineModel.location.latitude longitude:routineModel.location.longitude];
    Routine[@"name"] = routineModel.name;
    Routine[@"destinationName"] = routineModel.destinationName;
    Routine[@"timeToDestination"] = [NSNumber numberWithDouble:routineModel.timeToDestination];
    Routine[@"alarmTime"] = routineModel.alarmTime;
    Routine[@"otdTime"] = routineModel.otdTime;
    Routine[@"routineTasks"] = routineModel.routineTasks;
    Routine[@"daysToUse"] = [NSNumber numberWithDouble:routineModel.daysToUse];
//    Routine[@"location"] = locationPoint;
    [Routine saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            completionBlock(YES, error);
        } else {
            completionBlock(NO, error);
        }
    }];
}

@end
