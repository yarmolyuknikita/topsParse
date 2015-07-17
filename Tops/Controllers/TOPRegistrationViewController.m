//
//  TOPRegistrationViewController.m
//  Tops
//
//  Created by Никита Ярмолюк on 7/17/15.
//  Copyright (c) 2015 Nikita. All rights reserved.
//

#import "TOPRegistrationViewController.h"
#import "TOPHomeViewController.h"
#import "TOPSignupViewController.h"
#import <Parse/PFUser.h>
#import <MBProgressHUD.h>

@interface TOPRegistrationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UIButton *servicesType;
@property (weak, nonatomic) IBOutlet UILabel *servicesCost;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UIButton *registrationButton;
@property (weak, nonatomic) IBOutlet UIButton *imagePickerButton;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *email;


@end

@implementation TOPRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UINavigationBar *navigationBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, 320, 65)];
    //do something like background color, title, etc you self
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@"Регистрация"];
    navigationBar.items = [NSArray arrayWithObject:item];
    navigationBar.topItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"<" style:UIBarButtonItemStyleDone target:self action:@selector(backButtonPressed)];
    
    [_imagePickerButton addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [_registrationButton addTarget:self action:@selector(registrationButtomPressed) forControlEvents:UIControlEventTouchUpInside];
    
    _name.delegate = self;
    _address.delegate = self;
    _phone.delegate = self;
    _login.delegate = self;
    _password.delegate = self;
    _email.delegate = self;
    
    [_login setTag: 97];
    [_password setTag: 98];
    [_email setTag: 99];
    [_name setTag: 100];
    [_address setTag:101];
    [_phone setTag:102];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if(textField.tag == 97){
        [_password becomeFirstResponder];
    }
    else if(textField.tag == 98){
        [_email becomeFirstResponder];
    }
    else if(textField.tag == 99){
        [_name becomeFirstResponder];
    }
    else if(textField.tag == 100){
        [_phone becomeFirstResponder];
    }
    else if(textField.tag == 101){
        [_address becomeFirstResponder];
    }
    else if(textField.tag == 101){
        [textField resignFirstResponder];
        [self.view endEditing:YES];
    }
    
    return YES;
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
}

- (void)registrationButtomPressed {
    
    PFUser *user = [PFUser user];
    user.username = _login.text;
    user.password = _password.text;
    user.email = _email.text;
    
    // other fields can be set just like with PFObject
    user[@"name"] = _name.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            
            [self presentViewController:[TOPHomeViewController new] animated:YES completion:nil];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        else {
            
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)backButtonPressed {
    [self presentViewController:[TOPSignupViewController new] animated:YES completion:nil];
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
