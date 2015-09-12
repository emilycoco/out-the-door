//
//  locationConverter.m
//  Out The Door
//
//  Created by Emily Coco on 9/11/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "locationConverter.h"

@implementation locationConverter

-(CLLocationCoordinate2D)locationFromDict:(NSDictionary *)dict {
    CLLocationCoordinate2D point = CLLocationCoordinate2DMake([[dict valueForKey:@"lat"] floatValue], [[dict valueForKey:@"lon"] floatValue]);

    return point;
}

-(CLCircularRegion *)regionFromDict:(NSDictionary *)dict radius:(double)radius {
    CLLocationCoordinate2D point = CLLocationCoordinate2DMake([[dict valueForKey:@"lat"] floatValue], [[dict valueForKey:@"lon"] floatValue]);
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:point radius:radius identifier:[dict valueForKey:@"name"]];

    return region;
}

@end
