//
//  locationModel.h
//  Out The Door
//
//  Created by Emily Coco on 9/19/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OtdLocationManager.h"

@interface OtdLocationModel : NSObject

@property (strong, nonatomic) NSString *name;

@property (nonatomic) CLLocationCoordinate2D location;

@property (nonatomic) NSInteger radius;

@end
