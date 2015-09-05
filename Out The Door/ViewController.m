//
//  ViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;

@property (weak, nonatomic) IBOutlet CLRegion *homeGeofence;

@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager sharedInstance] setDelegate:self];
    [[LocationManager sharedInstance] checkUserPermissionForLocation];
    NSDictionary *currentLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"];
    CGPoint recentLocation = CGPointMake(38, -122);
    [self.homeMapView setCenter:recentLocation];

    float spanX = 0.00725;
    float spanY = 0.00725;
    MKCoordinateRegion* region;
//    region.span.latitudeDelta = spanX;
//    region.span.longitudeDelta = spanY;
    NSLog(@"blah%@", currentLocation);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationControllerDidUpdateLocation:(CLLocation  *)location {
    [self zoomToCurrentLocation];
}

- (void)zoomToCurrentLocation {
    float spanX = 0.00025;
    float spanY = 0.00025;
    MKCoordinateRegion region;
    region.center.latitude = self.homeMapView.userLocation.coordinate.latitude;
    region.center.longitude = self.homeMapView.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    [self.homeMapView setRegion:region];
}


//-(CLRegion *)regionFromLocation:(CLLocation *)location {
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(location.coordinate.latitude,
//                                                               location.coordinate.latitude);
//    CLRegion *home = [[CLCircularRegion alloc]initWithCenter:center
//                                                        radius:100.0
//                                                    identifier:@"home"];
////    [locationManager startMonitoringForRegion:home];
//    return  home;
//}

@end
