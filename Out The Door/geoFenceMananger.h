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

@interface geoFenceMananger : NSObject

@property (nonatomic) CLLocationCoordinate2D currentHomeLocation;

@property (strong, nonatomic) CLCircularRegion *currentHomeRegion;

-(BOOL)checkIsAtHome:(CLLocationCoordinate2D)location;

-(void)updateCurrentHome:(CLCircularRegion *)home;

@end
