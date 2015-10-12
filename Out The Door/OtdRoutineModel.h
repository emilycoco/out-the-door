//
//  OtdRoutineModel.h
//  Out The Door
//
//  Created by Emily Coco on 9/20/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtdLocationManager.h"
#import "OtdLocationModel.h"

@interface OtdRoutineModel : NSObject

@property (strong, nonatomic) NSString *objectId;

@property (strong, nonatomic) NSString *name;

@property (nonatomic) NSString *destinationName;

@property (nonatomic) NSTimeInterval timeToDestination;

@property (strong, nonatomic) NSDate *arriveToDestination;

@property (nonatomic) OtdLocationModel *location;

@property (strong, nonatomic) NSDate *alarmTime;

@property (strong, nonatomic) NSDate *otdTime;

@property (strong, nonatomic) NSMutableArray *routineTasks;

@property (nonatomic) NSInteger daysToUse;

@end
