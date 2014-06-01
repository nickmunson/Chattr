//
//  NPMMessageCell.h
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NPMMessage.h"
#import <Parse/Parse.h>

@interface NPMMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextView *messageTextView;
@property (strong, nonatomic) PFObject *message;

- (void)updateTextView;
+ (CGFloat)messageTextViewHeightWithText:(NSString *)text;
/*
+ (UIColor *)myColor;
+ (UIColor *)theirColor;
+ (UIFont *)messageTextViewFont;
+ (CGFloat)messageTextViewWidth;
+ (CGPoint)messageTextViewmyOrigin;
+ (CGPoint)messageTextViewTheirOrigin;
+ (NSLineBreakMode *)messageTextViewLineBreakMode;
 
 * More properties of the label that are needed to calulate the height
 * of a MessageCell in the TableView's heightForRowAtIndexPath method.
 */

@end
