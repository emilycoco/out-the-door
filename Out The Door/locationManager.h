//
//  locationManager.h
//  Out The Door
//
//  Created by Emily Coco on 8/30/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol LocationManagerDelegate

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;
- (void)startUpdatingLocation;

@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>

+(LocationManager *) sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (weak, nonatomic) id delegate;

- (void)checkUserPermissionForLocation;

-(void)startMonitoringForRegion:(CLRegion*)region;

@end
