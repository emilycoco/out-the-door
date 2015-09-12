//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "addLocationViewController.h"

@interface addLocationViewController () <MGLMapViewDelegate>

@property (nonatomic) MGLMapView *homeMapView;

@property (weak, nonatomic) IBOutlet UIView *mapContainer;

@property (nonatomic) CLLocationCoordinate2D recentLocation;

@property (weak, nonatomic) IBOutlet UITextField *locationName;

@end

@implementation addLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *homeLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][10];
    self.recentLocation = CLLocationCoordinate2DMake([[homeLocation valueForKey:@"lat"] floatValue], [[homeLocation valueForKey:@"lon"] floatValue]);

    // initialize the map view
    self.homeMapView = [[MGLMapView alloc] initWithFrame:self.mapContainer.bounds];
    self.homeMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // set the map's center coordinate
    [self.homeMapView setCenterCoordinate:self.recentLocation
                                zoomLevel:12
                                 animated:NO];

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

- (void)locationControllerDidUpdateLocation:(CLLocation *)location {

}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
