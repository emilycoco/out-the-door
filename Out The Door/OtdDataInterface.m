//
//  dataInterface.m
//  Out The Door
//
//  Created by Emily Coco on 9/19/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdDataInterface.h"

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

-(void)saveRoutine:(OtdRoutineModel *)routineModel completion:(void (^)(BOOL, PFObject *Routine, NSError *))completionBlock {
    PFObject *Routine = [PFObject objectWithClassName:@"Routine"];

    Routine[@"name"] = routineModel.name;
    Routine[@"destinationName"] = routineModel.destinationName;
    Routine[@"timeToDestination"] = [NSNumber numberWithDouble:routineModel.timeToDestination];
    Routine[@"otdTime"] = routineModel.otdTime;
    Routine[@"routineTasks"] = routineModel.routineTasks;
    Routine[@"daysToUse"] = [NSNumber numberWithDouble:routineModel.daysToUse];

    if (!routineModel.alarmTime) {
        Routine[@"alarmTime"] = [NSNull null];
    } else {
        Routine[@"alarmTime"] = routineModel.alarmTime;
    }

    if (!routineModel.location) {
        Routine[@"location"] = [NSNull null];
    } else {
//        PFGeoPoint *locationPoint = [PFGeoPoint geoPointWithLatitude:routineModel.location.longitude longitude:routineModel.location.longitude];
//            Routine[@"location"] = locationPoint;
    }

    [Routine saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"SAVE%@", Routine.objectId);
            completionBlock(YES, Routine, error);
        } else {
            completionBlock(NO, Routine, error);
        }
    }];
}

@end
