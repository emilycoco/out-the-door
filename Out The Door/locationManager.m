//
//  locationManager.m
//  Out The Door
//
//  Created by Emily Coco on 8/30/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "locationManager.h"


@implementation LocationManager

+(LocationManager *) sharedInstance {
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });

    return sharedInstance;
}

- (id)init {
    self = [super init];
    if(self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100; // meters
        _locationManager.delegate = self;
    }
    return self;
}

- (void)startUpdatingLocation {
    NSLog(@"Starting location updates");
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray*)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"Latitude %+.6f, Longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    self.currentLocation = location;

    [self.delegate locationControllerDidUpdateLocation:location];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(BOOL)didChange status:(CLAuthorizationStatus *)status {
    [self checkUserPermissionForLocation];
}


-(void)checkUserPermissionForLocation {
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestAlwaysAuthorization];
            } else {
                [self.locationManager startUpdatingLocation];
            }
            return;

        case kCLAuthorizationStatusAuthorizedAlways:
            [self.locationManager startUpdatingLocation];
            return;

        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self locationErrorAlert];
            return;
    }
}

-(void)locationErrorAlert {
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Location services are turned off for Out the Door" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
}

@end
