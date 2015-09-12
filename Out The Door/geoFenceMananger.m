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

- (id)init {
    self = [super init];
    if (self) {
        [[LocationManager sharedInstance] setDelegate:self];

        NSDictionary *currentHomeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][11];
        self.currentHomeRegion = [[[locationConverter alloc] init] regionFromDict:currentHomeKey radius:100];
    }

    return self;
}

-(void)updateCurrentHome:(CLCircularRegion *)home {
    if (self.currentHomeRegion) {
        [[LocationManager sharedInstance] stopMonitoringForRegion:self.currentHomeRegion];
    }
    self.currentHomeRegion = home;
    [[LocationManager sharedInstance] startMonitoringForRegion:self.currentHomeRegion];
    if ([self isLocationInRegion:[[LocationManager sharedInstance] currentLocation] region:self.currentHomeRegion]) {
        self.isAtHome = YES;
    } else {
        self.isAtHome = NO;
    }
    NSLog(@"home%d", [self isLocationInRegion:[[LocationManager sharedInstance] currentLocation] region:self.currentHomeRegion]);
}

-(BOOL)isLocationInRegion:(CLLocation *)location region:(CLCircularRegion *)region {
    CLLocationCoordinate2D coordLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);

    return [region containsCoordinate:coordLocation];
}

//-(CLRegion *)regionFromLocation:(CLLocationCoordinate2D)location {
//    CLCircularRegion *home = [[CLCircularRegion alloc]initWithCenter:location
//                                                              radius:10000.0
//                                                          identifier:@"home"];
//    return  home;
//}

- (void)locationControllerDidUpdateLocation:(CLLocation  *)location {

}

//-(void)startUpdatingLocation {
//    
//}

@end
