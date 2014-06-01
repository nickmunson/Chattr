//
//  NPMLoginVC.h
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPMLoginVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (assign, nonatomic) int signup;
@property (weak, nonatomic) IBOutlet UISegmentedControl *signupToggle;
- (IBAction)signupToggle:(id)sender;
+ (BOOL)isValidUsername:(NSString *)username;
+ (BOOL)isValidUser:(NSString *)username;
+ (UIAlertView *)badUsernameAlert;
+ (UIAlertView *)badUserAlert;
+ (UIAlertView *)userNotFoundAlert;

@end
