//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "settingsViewController.h"

@implementation settingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager sharedInstance]setDelegate:self];
    [[LocationManager sharedInstance].locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)addNewLocation:(id)sender {
    NSNumber *lat = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].coordinate.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].coordinate.longitude];
    NSDictionary *currentLocation=@{@"lat":lat,@"long":lon};

    NSMutableArray *homeLocations = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"]) {
        homeLocations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"] mutableCopy];
    }

    [homeLocations addObject:currentLocation];
    [[NSUserDefaults standardUserDefaults] setValue:homeLocations forKey:@"homeLocations"];
}

- (void)locationControllerDidUpdateLocation:(CLLocation *)location {
    [self zoomToCurrentLocation];
}

- (void)zoomToCurrentLocation {
    float spanX = 0.00025;
    float spanY = 0.00025;
    MKCoordinateRegion region;
    region.center.latitude = self.locationMapView.userLocation.coordinate.latitude;
    region.center.longitude = self.locationMapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.locationMapView setRegion:region];
}

@end
