//
//  TOPSignupViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 6/29/15.
//  Copyright (c) 2015 Nikita & Co. All rights reserved.
//

#import "TOPSignupViewController.h"
#import "TOPHomeViewController.h"
#import <Parse/PFUser.h>

@interface TOPSignupViewController ()

@property (nonatomic) UIButton *signupButton;
@property (nonatomic) UIButton *loginButton;
@property (nonatomic) TOPHomeViewController *homeViewController;

@end

@implementation TOPSignupViewController

@synthesize signupButton = _signupButton;
@synthesize loginButton = _loginButton;
@synthesize homeViewController = _homeViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _signupButton = [UIButton new];
    _signupButton.translatesAutoresizingMaskIntoConstraints = NO;
    _signupButton.backgroundColor = [UIColor orangeColor];
    [_signupButton setTitle:@"Sign up"
                   forState:UIControlStateNormal];
    [self.view addSubview:_signupButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_signupButton]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_signupButton)]];
    
    _loginButton = [UIButton new];
    _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    _loginButton.backgroundColor = [UIColor orangeColor];
    [_loginButton setTitle:@"Log in"
                  forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_loginButton]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_loginButton)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_signupButton(50)]-10-[_loginButton(50)]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_loginButton, _signupButton)]];
    
    [_loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loginButtonPressed:(id)sender {
    
    [PFUser logInWithUsernameInBackground:@"qwe" password:@"qwe"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self presentViewController:[TOPHomeViewController new]
                                                               animated:YES
                                                             completion:nil];
                                            NSLog(@"Successfully logged in");

                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"fail to log in");
                                        }
                                    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
