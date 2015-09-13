//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "addLocationViewController.h"
@import GoogleMaps;

@interface addLocationViewController ()

@property (weak, nonatomic) IBOutlet GMSMapView *addLocationMapView;

@property (nonatomic) CLLocationCoordinate2D showLocation;

@property (weak, nonatomic) IBOutlet UITextField *locationName;

@property (strong, nonatomic) geoFenceMananger *currentHomeManager;

@end

@implementation addLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LocationManager sharedInstance] setDelegate:self];

    self.currentHomeManager = [[geoFenceMananger alloc] init];

    if([LocationManager sharedInstance].currentLocation.latitude != 0
       && [LocationManager sharedInstance].currentLocation.longitude != 0) {
        self.showLocation = [LocationManager sharedInstance].currentLocation;
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
    NSNumber *lat = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].latitude];
    NSNumber *lon = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].longitude];
    NSString *name = self.locationName.text;
    NSDictionary *currentLocation= [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     name, @"name",
                                     lat, @"lat",
                                     lon, @"lon", nil];

    NSMutableArray *homeLocations = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"]) {
        homeLocations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"] mutableCopy];
    }

    [homeLocations addObject:currentLocation];
    [[NSUserDefaults standardUserDefaults] setValue:homeLocations forKey:@"homeLocations"];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
