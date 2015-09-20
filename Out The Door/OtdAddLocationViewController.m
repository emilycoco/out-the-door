//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdAddLocationViewController.h"
@import GoogleMaps;

@interface OtdAddLocationViewController ()

@property (weak, nonatomic) IBOutlet GMSMapView *addLocationMapView;

@property (nonatomic) CLLocationCoordinate2D showLocation;

@property (weak, nonatomic) IBOutlet UITextField *locationName;

@property (strong, nonatomic) OtdGeoFenceMananger *currentHomeManager;

@end

@implementation OtdAddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[OtdLocationManager sharedInstance] setDelegate:self];

    self.currentHomeManager = [[OtdGeoFenceMananger alloc] init];

    if([OtdLocationManager sharedInstance].currentLocation.latitude != 0
       && [OtdLocationManager sharedInstance].currentLocation.longitude != 0) {
        self.showLocation = [OtdLocationManager sharedInstance].currentLocation;
    } else {
        self.showLocation = self.currentHomeManager.currentHomeLocation;
    }

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.showLocation.latitude
                                                            longitude:self.showLocation.longitude
                                                                 zoom:18];
    self.addLocationMapView.camera = camera;
    self.addLocationMapView.frame = CGRectZero;
    self.addLocationMapView.myLocationEnabled = YES;

    GMSMarker *newLocation = [GMSMarker markerWithPosition:self.showLocation];
    newLocation.title = @"newLocation";
    newLocation.map = self.addLocationMapView;

    //Home area geofence marker
    GMSCircle *newLocationRadius = [GMSCircle circleWithPosition:self.showLocation
                                                   radius:18];
    newLocationRadius.fillColor = [UIColor colorWithRed:.25 green:0 blue:.25 alpha:0.1];
    newLocationRadius.strokeColor = [UIColor colorWithRed:.25 green:0 blue:.25 alpha:.5];
    newLocationRadius.strokeWidth = 5;
    newLocationRadius.map = self.addLocationMapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addNewLocation:(id)sender {
    OtdLocationModel *newLocationModel = [[OtdLocationModel alloc] init];
    newLocationModel.name = self.locationName.text;
    newLocationModel.location = CLLocationCoordinate2DMake([[OtdLocationManager sharedInstance] currentLocation].latitude, [[OtdLocationManager sharedInstance] currentLocation].latitude);
    newLocationModel.radius = 30;

    [[OtdDataInterface sharedInstance] addLocation:newLocationModel completion:^(BOOL success, NSError *error) {
        if (success) {

        } else {

        }
    }];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
