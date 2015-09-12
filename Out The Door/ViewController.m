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
    NSDictionary *homeLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"][11];
    self.recentLocation = CLLocationCoordinate2DMake([[homeLocation valueForKey:@"lat"] floatValue], [[homeLocation valueForKey:@"lon"] floatValue]);
    self.locationLabel.text = [NSString stringWithFormat:@"You're at %@", [homeLocation valueForKey:@"name"]];

    // initialize the map view
    self.homeMapView = [[MGLMapView alloc] initWithFrame:self.mapContainer.bounds];
    self.homeMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    // set the map's center coordinate
    [self.homeMapView setCenterCoordinate:self.recentLocation
                            zoomLevel:17
                             animated:NO];

    [self.homeMapView setShowsUserLocation:YES];
    NSURL *styleUrl = [[NSURL alloc] initWithString:@"asset://styles/light-v7.json"];
    [self.homeMapView setStyleURL:styleUrl];

    [self.mapContainer addSubview:self.homeMapView];
    self.homeMapView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self performSelector:@selector(drawShape) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawShape
{
    // Create a coordinates array to all of the coordinates for our shape.
    CLLocationCoordinate2D shapeStart = CLLocationCoordinate2DMake(self.recentLocation.latitude, self.recentLocation.longitude  - .0001);

    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(shapeStart.latitude, shapeStart.longitude),
        CLLocationCoordinate2DMake(shapeStart.latitude + .0001, shapeStart.longitude + .0001),
        CLLocationCoordinate2DMake(shapeStart.latitude, shapeStart.longitude + .0002),
        CLLocationCoordinate2DMake(shapeStart.latitude - .0001, shapeStart.longitude + .0002),
        CLLocationCoordinate2DMake(shapeStart.latitude - .0001, shapeStart.longitude)

    };
    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);

    // Create our shape with the formatted coordinates array
    MGLPolygon *shape = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];

    // Add the shape to the map
    [self.homeMapView addAnnotation:shape];
}


#pragma mapView delegate methods

- (CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape *)annotation
{
    // Set the alpha for shape annotations to 0.5 (half opacity)
    return 0.3f;
}

- (UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation
{
    // Set the stroke color for shape annotations
    return [UIColor whiteColor];
}

- (UIColor *)mapView:(MGLMapView *)mapView fillColorForPolygonAnnotation:(MGLPolygon *)annotation
{
    // Mapbox cyan fill color
    return [UIColor blueColor];
}

@end
