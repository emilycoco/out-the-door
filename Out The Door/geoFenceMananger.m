//
//  geoFenceMananger.m
//  Out The Door
//
//  Created by Emily Coco on 9/10/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "geoFenceMananger.h"

@interface geoFenceMananger ()

@property BOOL locationUpdatedFirstTime;

@end

@implementation geoFenceMananger

-(id)init {
    self = [super init];
    if (self) {
        [[LocationManager sharedInstance] setDelegate:self];
        locationConverter *converter = [[locationConverter alloc] init];
        NSDictionary *currentHomeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferredLocation"];

        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"preferredLocation"]) {
            self.currentHomeLocation = [converter locationFromDict:currentHomeKey];
        } else {
            //if we have no previous location, set coordinates to default point until user location updated
            self.currentHomeLocation = CLLocationCoordinate2DMake(37.7833, -122.4167);
        }

        self.currentHomeRegion = [[CLCircularRegion alloc] initWithCenter:self.currentHomeLocation radius:30 identifier:@"homeRegion"];
        self.locationUpdatedFirstTime = NO;
    }

    return self;
}

-(void)updateCurrentHome:(CLLocationCoordinate2D)home {
    self.currentHomeLocation = home;
    self.currentHomeRegion = [[CLCircularRegion alloc] initWithCenter:home radius:30 identifier:@"homeRegion"];
    self.isAtHome = [self checkIsAtHome:home];
}

-(BOOL)checkIsAtHome:(CLLocationCoordinate2D)location {
    if([self.currentHomeRegion containsCoordinate:location]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)locationControllerDidUpdateLocation:(CLLocationCoordinate2D)location {

    BOOL newHomeState = [self checkIsAtHome:location];

    if (self.locationUpdatedFirstTime) {
        NSString *homeChange = @"UNDETERMINED";
        if (newHomeState != self.isAtHome) {
            if (newHomeState && !self.isAtHome) {
                homeChange = @"ENTER_HOME";
                [[NSNotificationCenter defaultCenter] postNotificationName:@"atHomeChange"
                                                                    object:homeChange
                                                                  userInfo:nil];
            } else {
                homeChange = @"LEAVE_HOME";
            }
            NSLog(@"HOMECHANGE%@", homeChange);
        }
    } else {
        [self updateCurrentHome:location];
    }

    self.isAtHome = newHomeState;
    self.locationUpdatedFirstTime = YES;
}

@end
