//
//  AppDelegate.m
//  Out The Door
//
//  Created by Emily Coco on 8/29/15.
//  Copyright (c) 2015 Emily Coco. All rights reserved.
//

#import "OtdAppDelegate.h"
#import <Parse/Parse.h>
@import GoogleMaps;

@interface OtdAppDelegate () <UIAlertViewDelegate>

@end

@implementation OtdAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Initialize Parse.
    [Parse setApplicationId:@"Kcahc1nmwmSGIhA5VhHFPeLfd8ZkQ2p4wZ3lEuXl"
                  clientKey:@"SOluX5nZYKtRicjfOvq7c85Qrq5v9nLI4Jv4USrp"];

    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    [GMSServices provideAPIKey:@"AIzaSyCT1p64AitvvBA337x-lmugwiHOfziNEXY"];
    [[OtdLocationManager sharedInstance] checkUserPermissionForLocation];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showOutTheDoor:)
                                                 name:@"atHomeChange"
                                               object:nil];
    return YES;
}

-(void)showOutTheDoor:(NSNotification *)notification {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nice Job!"
                                                    message:@"You're out the door for the day!"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil,nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
