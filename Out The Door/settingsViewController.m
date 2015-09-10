//
//  settingsViewController.m
//  Out The Door
//
//  Created by Emily Coco on 9/8/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController() <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *locationPicker;

@property (nonatomic) NSArray *availableLocations;

@end

@implementation settingsViewController

- (void)viewDidLoad {
    _locationPicker.dataSource = self;
    _locationPicker.delegate = self;
    self.availableLocations = [[[NSUserDefaults standardUserDefaults] objectForKey:@"homeLocations"] mutableCopy];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setLocation:(NSDictionary *)location {
    [[NSUserDefaults standardUserDefaults] setObject:location forKey:@"preferredLocation"];
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
    [self setLocation:[self.availableLocations objectAtIndex:row]];
}

@end
