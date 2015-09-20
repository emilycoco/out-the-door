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
    PFObject *location = [PFObject objectWithClassName:@"Location"];
    PFGeoPoint *locationPoint = [PFGeoPoint geoPointWithLatitude:locationModel.location.latitude longitude:locationModel.location.longitude];
    location[@"name"] = locationModel.name;
    location[@"location"] = locationPoint;
    location[@"radius"] = @(locationModel.radius);
    [location saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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

@end
