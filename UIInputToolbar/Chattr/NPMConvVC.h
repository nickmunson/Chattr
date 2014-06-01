//
//  NPMConvVC.h
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPMUser.h"

@interface NPMConvVC : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@property (strong,nonatomic) NSString *username;
@property (weak, nonatomic) IBOutlet UIView *messageBarView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (IBAction)send:(id)sender;
@end
