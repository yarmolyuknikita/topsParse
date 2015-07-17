//
//  TOPRegistrationLauncherViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/17/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPRegistrationLauncherViewController.h"
#import "TOPHomeViewController.h"
#import <Parse/PFUser.h>
#import <MBProgressHUD.h>
#import "TOPRegistrationViewController.h"
#import <RDVKeyboardAvoidingScrollView.h>

@interface TOPRegistrationLauncherViewController ()

@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet RDVKeyboardAvoidingScrollView *scrollView;

@end

@implementation TOPRegistrationLauncherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    _loginTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    [_loginButton addTarget:self action:@selector(loginButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_registrationButton addTarget:self action:@selector(registrationButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    _scrollView.delegate = self;
    [_scrollView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
}

- (void)loginButtonPressed {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [PFUser logInWithUsernameInBackground:_loginTextField.text password:_passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                            [self presentViewController:[TOPHomeViewController new]
                                                               animated:YES
                                                             completion:nil];
                                            NSLog(@"Successfully logged in");
                                            
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSLog(@"fail to log in");
                                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        }
                                    }];
    
}

- (void)registrationButtonPressed {
    
    [self presentViewController:[TOPRegistrationViewController new] animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
