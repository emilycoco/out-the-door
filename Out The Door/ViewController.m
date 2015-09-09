//
//  ViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <MGLMapViewDelegate>

@property (weak, nonatomic) IBOutlet CLRegion *homeGeofence;

@property (nonatomic) MGLMapView *homeMapView;

@property (weak, nonatomic) IBOutlet UIView *mapContainer;

@property (nonatomic) CLLocationCoordinate2D recentLocation;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager sharedInstance] setDelegate:self];
    [[LocationManager sharedInstance] checkUserPermissionForLocation];
    NSDictionary *homeLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][6];
    self.recentLocation = CLLocationCoordinate2DMake([[homeLocation valueForKey:@"lat"] floatValue], [[homeLocation valueForKey:@"lon"] floatValue]);
    self.locationLabel.text = [NSString stringWithFormat:@"You're at %@", [homeLocation valueForKey:@"name"]];

    // initialize the map view
    self.homeMapView = [[MGLMapView alloc] initWithFrame:self.mapContainer.bounds];
    self.homeMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // set the map's center coordinate
    [self.homeMapView setCenterCoordinate:self.recentLocation
                            zoomLevel:17
                             animated:NO];
    
    [self.mapContainer addSubview:self.homeMapView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
    point.coordinate = self.recentLocation;
    point.title = @"Hello world!";
    point.subtitle = @"Welcome to The Ellipse.";

    // Add annotation `point` to the map
    [self.homeMapView addAnnotation:point];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationControllerDidUpdateLocation:(CLLocation  *)location {

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
