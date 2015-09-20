//
//  dataInterface.h
//  Out The Door
//
//  Created by Emily Coco on 9/19/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtdLocationModel.h"

@interface OtdDataInterface : NSObject

//add new routine with properties:name, days to use, alarm time, otd time, location, location radius, things to do
//add new routine
//add location
//get all locations with completion block
//get all routines with completion block
//get all things to do

+(OtdDataInterface *) sharedInstance;

-(void)addLocation:(OtdLocationModel *)locationModel completion:(void(^)(BOOL success, NSError *error))completionBlock;

-(void)getAllLocations:(void(^)(NSArray *locations, NSError *error))completionBlock;

@end
