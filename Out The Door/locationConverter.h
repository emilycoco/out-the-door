//
//  locationConverter.h
//  Out The Door
//
//  Created by Emily Coco on 9/11/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "locationManager.h"

@interface locationConverter : NSObject

-(CLLocationCoordinate2D)locationFromDict:(NSDictionary *)dict;

-(CLCircularRegion *)regionFromDict:(NSDictionary *)dict radius:(double)radius;

@end
