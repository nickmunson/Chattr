//
//  NPMLoginVC.m
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.


#import "NPMLoginVC.h"
#import <Parse/Parse.h>

@interface NPMLoginVC ()

@end

@implementation NPMLoginVC

#pragma mark - View Controller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.usernameField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - UI Delegate

- (IBAction)signupToggle:(id)sender {
    _signup = (int)[sender selectedSegmentIndex];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    UIAlertView *alert = nil;
    if (textField.tag) {
        NSString *pass = textField.text;
        NSString *name = self.usernameField.text;
        if ([self signupToggle].selectedSegmentIndex == 1) {
            if ([NPMLoginVC isStrongPassword:pass]) {
                if ([NPMLoginVC isValidUsername:name]) {
                    if ([self signupWithUsername:name password:pass]) {
                        PFUser *user = [PFUser user];
                        user.username = name;
                        user.password = pass;
                        
                        [user signUpInBackgroundWithBlock:^(BOOL success, NSError *__strong error){
                            [PFUser logInWithUsernameInBackground:name password:pass
                                                            block:^(PFUser *user, NSError *error) {
                                                                if (user) {
                                                                    [self performSegueWithIdentifier:@"logIn" sender:self];
                                                                } else {
                                                                    [[NPMLoginVC wrongPasswordAlert] show];
                                                                }
                                                            }];}];
                    }
                    else
                        alert = [NPMLoginVC usernameTakenAlert];
                }
                else
                    alert = [NPMLoginVC badUsernameAlert];
            }
            else
                alert = [NPMLoginVC weakPasswordAlert];
        }
        else { // login
            if ([NPMLoginVC isValidUsername:name]) {
                [PFUser logInWithUsernameInBackground:name password:pass
                                                block:^(PFUser *user, NSError *error) {
                                                    if (user) {
                                                        [self performSegueWithIdentifier:@"logIn" sender:self];
                                                    } else {
                                                        [[NPMLoginVC wrongPasswordAlert] show];
                                                    }
                                                }];
            }
            else
                alert = [NPMLoginVC wrongPasswordAlert];
        }
    }
    else {
        NSInteger nextTag = textField.tag + 1; // Try to find next responder
        UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
        if (nextResponder) { // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else { // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
        return YES; // We do not want UITextField to insert line-breaks.
    }
    [alert show];
    [textField resignFirstResponder];
    return YES;
}

# pragma mark - Input Verification

+ (BOOL)isStrongPassword:(NSString *)pass {
    return ![pass isEqualToString:@""];
}


+ (BOOL)isValidUser:(NSString *)name {
    PFQuery *usrQuery = [PFQuery queryWithClassName:@"_User"];
    [usrQuery whereKey:@"username" equalTo:name];
    NSInteger users = [usrQuery countObjects];
    return users != 0;
}

+ (BOOL)isValidUsername:(NSString *)name {
    return (name.length >= 4);
}

# pragma mark - Helper Functions
// move to seperate file

+ (UIAlertView *)userNotFoundAlert {
    return [[UIAlertView alloc] initWithTitle:@"User Not Found"
                                      message:@"Check your spelling and internet connection."
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

+ (UIAlertView *)wrongPasswordAlert {
    return [[UIAlertView alloc] initWithTitle:@"Wrong Password"
                                      message:@"Username and password don't match."
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

+ (UIAlertView *)badUsernameAlert {
    return [[UIAlertView alloc] initWithTitle:@"Bad Username"
                                      message:@"Usernames are at least 4 characters."
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

+ (UIAlertView *)badUserAlert {
    return [[UIAlertView alloc] initWithTitle:@"User not found"
                                      message:@"Please enter a valid case-sensitive username"
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

+ (UIAlertView *)weakPasswordAlert {
    return [[UIAlertView alloc] initWithTitle:@"Weak Password"
                                      message:@"Must be at least 12 characters."
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

+ (UIAlertView *)usernameTakenAlert {
    return [[UIAlertView alloc] initWithTitle:@"Username Taken"
                                      message:@"Please try a different username"
                                     delegate:nil
                            cancelButtonTitle:@"Try again"
                            otherButtonTitles:nil];
}

- (BOOL)signupWithUsername:(NSString *)name password:(NSString *)pass {
    return YES;
}

- (BOOL)login:(NSString *)name withPassword:(NSString *)pass {
    return YES;
}

@end
