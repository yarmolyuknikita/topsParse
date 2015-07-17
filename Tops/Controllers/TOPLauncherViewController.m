//
//  TOPLauncherViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 6/29/15.
//  Copyright (c) 2015 Nikita & Co. All rights reserved.
//

#import "TOPLauncherViewController.h"
#import <Parse/PFUser.h>
#import "TOPHomeViewController.h"
#import "TOPSignupViewController.h"

@interface TOPLauncherViewController ()

@end

@implementation TOPLauncherViewController

#pragma mark - UIViewController Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    if([PFUser currentUser]){
//        [self presentViewController:[TOPHomeViewController new]
//                           animated:YES
//                         completion:nil];
//    }else{
        [self presentViewController:[TOPSignupViewController new]
                           animated:YES
                         completion:nil];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
