//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "addLocationViewController.h"

@interface addLocationViewController () 

@property (nonatomic) MGLMapView *homeMapView;

@property (weak, nonatomic) IBOutlet UIView *mapContainer;

@property (nonatomic) CLLocationCoordinate2D homeLocation;

@property (weak, nonatomic) IBOutlet UITextField *locationName;

@property (strong, nonatomic) geoFenceMananger *currentHomeManager;

@end

@implementation addLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentHomeManager = [[geoFenceMananger alloc] init];

    self.homeLocation = self.currentHomeManager.currentHomeLocation;

    // initialize the map view
    self.homeMapView = [[MGLMapView alloc] initWithFrame:self.mapContainer.bounds];
    self.homeMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // set the map's center coordinate
    [self.homeMapView setCenterCoordinate:self.homeLocation
                                zoomLevel:17
                                 animated:NO];

    [self.homeMapView setShowsUserLocation:YES];
    NSURL *styleUrl = [[NSURL alloc] initWithString:@"asset://styles/light-v7.json"];
    [self.homeMapView setStyleURL:styleUrl];

    [self.mapContainer addSubview:self.homeMapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addNewLocation:(id)sender {
    NSNumber *lat = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].coordinate.latitude];
    NSNumber *lon = [NSNumber numberWithDouble:[[LocationManager sharedInstance] currentLocation].coordinate.longitude];
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
