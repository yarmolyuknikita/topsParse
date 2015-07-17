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
#import <MBProgressHUD/MBProgressHUD.h>
#import "TOPRegistrationViewController.h"
#import "TOPRegistrationLauncherViewController.h"

@interface TOPSignupViewController ()

@property (nonatomic) UIButton *signupButton;
@property (nonatomic) UIButton *loginButton;
@property (nonatomic) TOPHomeViewController *homeViewController;
@property (nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation TOPSignupViewController

@synthesize signupButton = _signupButton;
@synthesize loginButton = _loginButton;
@synthesize homeViewController = _homeViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _signupButton = [UIButton new];
    _signupButton.translatesAutoresizingMaskIntoConstraints = NO;
    _signupButton.backgroundColor = [UIColor grayColor];
    [_signupButton setTitle:@"Войти как мастер"
                   forState:UIControlStateNormal];
    [self.view addSubview:_signupButton];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_signupButton]-20-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_signupButton)]];
    
    _loginButton = [UIButton new];
    _loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    _loginButton.backgroundColor = [UIColor grayColor];
    [_loginButton setTitle:@"Войти как клиент"
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
    [_signupButton addTarget:self action:@selector(signupButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)signupButtonPressed:(id)sender{
    [self presentViewController:[TOPRegistrationLauncherViewController new]
                       animated:YES
                     completion:nil];
}

-(void)loginButtonPressed:(id)sender {
    
    [self presentViewController:[TOPHomeViewController new]
                       animated:YES
                     completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
