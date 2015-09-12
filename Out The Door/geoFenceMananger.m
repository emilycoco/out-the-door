//
//  geoFenceMananger.m
//  Out The Door
//
//  Created by Emily Coco on 9/10/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "geoFenceMananger.h"

@implementation geoFenceMananger

//set current geofence for the day
//monitor location, send update when enter/leave geofence
//save location status

-(id)init {
    self = [super init];
    if (self) {
        [[LocationManager sharedInstance] setDelegate:self];
        locationConverter *converter = [[locationConverter alloc] init];
        NSDictionary *currentHomeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][11];
        self.currentHomeRegion = [converter regionFromDict:currentHomeKey radius:100];
        self.currentHomeLocation = [converter locationFromDict:currentHomeKey];
    }

    return self;
}

-(void)updateCurrentHome:(CLCircularRegion *)home {
    if (self.currentHomeRegion) {
        [[LocationManager sharedInstance] stopMonitoringForRegion:self.currentHomeRegion];
    }

    self.currentHomeLocation = CLLocationCoordinate2DMake(home.center.latitude, home.center.longitude);
    self.currentHomeRegion = home;

    [[LocationManager sharedInstance] startMonitoringForRegion:self.currentHomeRegion];
    [self  checkIsAtHome:[[LocationManager sharedInstance] currentLocation] region:self.currentHomeRegion];
}

-(void)checkIsAtHome:(CLLocation *)location region:(CLCircularRegion *)region {
    CLLocationCoordinate2D coordLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);

    if([region containsCoordinate:coordLocation]) {
        self.isAtHome = YES;
    } else {
        self.isAtHome = NO;
    }
}

- (void)locationControllerDidUpdateLocation:(CLLocation  *)location {
        [self checkIsAtHome:[[LocationManager sharedInstance] currentLocation] region:self.currentHomeRegion];
        NSLog(@"LOCATION%f%fHOME%@", location.coordinate.latitude, location.coordinate.longitude, self.currentHomeRegion);
        NSLog(@"ATHOME%d", [self isAtHome]);
}


@end
