//
//  NPMChatsTVC.h
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPMChatsTVC : UITableViewController <UINavigationControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSArray *searchResults;
- (IBAction)addFriend:(id)sender;
- (IBAction)logOut:(id)sender;

@end
