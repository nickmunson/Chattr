//
//  NPMMessageCell.h
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface NPMMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) PFObject *message;

- (void)updateTextView;
+ (CGFloat)messageTextViewHeightWithText:(NSString *)text;

@end
