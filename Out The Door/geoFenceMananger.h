//
//  geoFenceMananger.h
//  Out The Door
//
//  Created by Emily Coco on 9/10/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "locationManager.h"
#import "locationConverter.h"

@interface geoFenceMananger : NSObject <LocationManagerDelegate>

@property (nonatomic) CLLocationCoordinate2D currentHomeLocation;

@property (strong, nonatomic) CLCircularRegion *currentHomeRegion;

@property (nonatomic) BOOL isAtHome;

-(BOOL)checkIsAtHome:(CLLocationCoordinate2D)location;

-(void)updateCurrentHome:(CLLocationCoordinate2D)home;

@end
