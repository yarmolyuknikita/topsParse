//
//  TOPAppDelegate.m
//  Tops
//
//  Created by Никита Ярмолюк on 6/30/15
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPAppDelegate.h"
#import "TOPLauncherViewController.h"
#import <Parse/Parse.h>

@implementation TOPAppDelegate

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [TOPLauncherViewController new];
    [self.window makeKeyAndVisible];
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"nAHRa7Hs2wnioOvvnWdas8PBxRhThOryGAxTQJhf"
                  clientKey:@"Qs7PU8hjz7TRCNDPj20dmKlHhiKnC7vK5vrH0rGt"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    return YES;
}
@end
