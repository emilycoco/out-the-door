//
//  OtdChooseLocationViewController.h
//  Out The Door
//
//  Created by Emily Coco on 9/8/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtdGeoFenceMananger.h"
#import "locationConverter.h"
#import "OtdDataInterface.h"
#import "OtdLocationModel.h"

@protocol OtdAddLocationDelegate

- (void)addLocation:(OtdLocationModel *)location;

@end

@interface OtdChooseLocationViewController : UIViewController

@property (weak, nonatomic) id delegate;

@end
