//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/8/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdSettingsViewController.h"

@interface OtdSettingsViewController() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;

@property (nonatomic) NSArray *availableLocations;

@property (weak, nonatomic) NSDictionary *selectedLocation;

@end

@implementation OtdSettingsViewController

- (void)viewDidLoad {
    _locationPicker.dataSource = self;
    _locationPicker.delegate = self;
    self.availableLocations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"] mutableCopy];
    self.selectedLocation = self.availableLocations[0];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component {
    return self.availableLocations.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    return [[self.availableLocations objectAtIndex:row] valueForKey:@"name"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedLocation = [self.availableLocations objectAtIndex:row];
}

- (IBAction)setLocation:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:self.selectedLocation forKey:@"preferredLocation"];
}

@end
