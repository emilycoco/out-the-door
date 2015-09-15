//
//  ViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "ViewController.h"
@import GoogleMaps;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GMSMapView *homeMapView;

@property (nonatomic) CLLocationCoordinate2D homeLocation;

@property (nonatomic) CLCircularRegion *homeLocationRegion;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (strong, nonatomic) geoFenceMananger *currentHomeManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager sharedInstance] setDelegate:self];

    self.currentHomeManager = [[geoFenceMananger alloc] init];

    self.homeLocation = self.currentHomeManager.currentHomeLocation;
    self.homeLocationRegion = self.currentHomeManager.currentHomeRegion;
    self.locationLabel.text = self.homeLocationRegion.identifier;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.homeLocation.latitude
                                                            longitude:self.homeLocation.longitude
                                                                 zoom:18];
    self.homeMapView.camera = camera;
    self.homeMapView.frame = CGRectZero;
    self.homeMapView.myLocationEnabled = YES;

    //Home area geofence marker
    GMSCircle *homeRadius = [GMSCircle circleWithPosition:self.homeLocation
                                             radius:18];
    homeRadius.fillColor = [UIColor colorWithRed:0 green:.25 blue:0 alpha:0.1];
    homeRadius.strokeColor = [UIColor colorWithRed:0 green:.25 blue:0 alpha:0.5];
    homeRadius.strokeWidth = 5;
    homeRadius.map = self.homeMapView;

    GMSMarker *home = [GMSMarker markerWithPosition:self.homeLocation];
    home.title = @"home";
    home.icon = [UIImage imageNamed:@"home"];
    home.map = self.homeMapView;
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationControllerDidUpdateLocation:(CLLocationCoordinate2D)location {
        if ([self.currentHomeManager checkIsAtHome:location]) {
            self.statusLabel.text = @"Get ready to get out the door!";
        } else {
            self.statusLabel.text = @"You're already out the door today!";
        }
}

@end
