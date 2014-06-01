//
//  NPMAddFriendVC.h
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPMUser.h"

@protocol AddFriendDelegateProtocol <NSObject>

- (void)addFriend:(NPMUser *)user fromVC:(UIViewController *) addFriendVC;
- (void)cancelAddFriend:(UIViewController *)addFriendVC;

@end

@interface NPMAddFriendVC : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) id<AddFriendDelegateProtocol> delegate;
- (IBAction)cancel:(id)sender;

@end
