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
        NSDictionary *currentHomeKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"preferredLocation"];
    
        self.currentHomeRegion = [converter regionFromDict:currentHomeKey radius:100];
        self.currentHomeLocation = [converter locationFromDict:currentHomeKey];
    }

    return self;
}

-(void)updateCurrentHome:(CLLocationCoordinate2D)home {
    self.currentHomeLocation = home;
    self.currentHomeRegion = [[CLCircularRegion alloc] initWithCenter:home radius:18 identifier:@"homeRegion"];
}

-(BOOL)checkIsAtHome:(CLLocationCoordinate2D)location {
    if([self.currentHomeRegion containsCoordinate:location]) {
        return YES;
    } else {
        return NO;
    }
}

@end
