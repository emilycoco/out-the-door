//
//  geoFenceMananger.m
//  Out The Door
//
//  Created by Emily Coco on 9/10/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "geoFenceMananger.h"

@implementation geoFenceMananger

-(id)init {
    self = [super init];
    if (self) {
        locationConverter *converter = [[locationConverter alloc] init];
        NSDictionary *currentHomeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][0];
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
    [self  checkIsAtHome:[[LocationManager sharedInstance] currentLocation]];
}

-(BOOL)checkIsAtHome:(CLLocationCoordinate2D)location {
    if([self.currentHomeRegion containsCoordinate:location]) {
        return YES;
    } else {
        return NO;
    }
}

@end
