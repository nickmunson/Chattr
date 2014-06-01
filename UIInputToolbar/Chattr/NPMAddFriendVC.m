//
//  NPMAddFriendVC.m
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMAddFriendVC.h"
#import "NPMUser.h"
#import "NPMLoginVC.h"
#import "NPMBackendTools.h"

@interface NPMAddFriendVC ()

@end

@implementation NPMAddFriendVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
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

- (IBAction)cancel:(id)sender {
    [self.delegate cancelAddFriend: self];
    
}

- (IBAction)Done:(id)sender {
    NSString *username = self.usernameField.text;
    if ([NPMLoginVC isValidUsername:username]) {
        NPMUser *user = [[NPMUser alloc] initWithUsername:username];
        if (user) {
            [self returnWithUser:user];
        }
        else {
            UIAlertView *alert = [NPMLoginVC userNotFoundAlert];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [NPMLoginVC badUsernameAlert];
        [alert show];
    }
    return;
}

- (void)returnWithUser:(NPMUser *)user {
    // tell delegate new user found
    [self.delegate addFriend:user fromVC:self];
    return;
}

#pragma mark - UITextField dlegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *username = textField.text;
    if ([NPMLoginVC isValidUsername:username]) {
        [textField resignFirstResponder];
        NPMUser *user = [[NPMUser alloc] initWithUsername:username];
        if (user) {
            [self returnWithUser:user];
            return YES;
        }
        else {
            UIAlertView *alert = [NPMLoginVC userNotFoundAlert];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [NPMLoginVC badUsernameAlert];
        [alert show];
    }
    return NO;
}

@end
