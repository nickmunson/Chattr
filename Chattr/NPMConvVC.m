//
//  NPMConvVC.m
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "UINavigationController+SGProgress.h"
#import "NPMConvVC.h"
#import "NPMMessageCell.h"
#import <Parse/Parse.h>

@interface NPMConvVC ()
@property (strong, nonatomic) NSMutableArray *messages;
@end

@implementation NPMConvVC
@synthesize username, messageBarView, messageTextField, messages, messageTableView;

#pragma mark - View Setup
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // messagesContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCells];
    self.messages = [[NSMutableArray alloc] init];
    [self setupMessages];
    self.messageTextField.delegate = self;
    self.navigationItem.title = username;
    [self setupInsets];
    [self setupGestureRecognizer];
    [self setupTextFieldNotifications];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	/* Listen for keyboard */
    [self setupKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	/* No longer listen for keyboard */
    [self removeKeyboardNotifications];
}

- (void)setupMessages {
    PFQuery *msgQuery = [PFQuery queryWithClassName:@"Message"];
    NSArray *usernames = @[self.username, [[PFUser currentUser] objectForKey:@"username"]];
    [msgQuery whereKey:@"toUsername" containedIn:usernames];
    [msgQuery whereKey:@"fromUsername" containedIn:usernames];
    [msgQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.messages = [[NSMutableArray alloc] initWithArray:objects];
        self.messages = [[self.messages sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            PFObject *msg1 = (PFObject *)obj1;
            PFObject *msg2 = (PFObject *)obj2;
            NSString *dateStr1 = msg1[@"createdDatePosix"];
            NSString *dateStr2 = msg2[@"createdDatePosix"];
            NSDate *date1 = [NSDate dateWithTimeIntervalSince1970:[dateStr1 doubleValue]];
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[dateStr2 doubleValue]];
            return [date1 compare:date2];
        }] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.messageTableView reloadData];
        });
    }];

}

- (void)registerCells {
    UINib *messageFromMeNib = [UINib nibWithNibName:@"NPMMessageCellFromMe" bundle:[NSBundle mainBundle]];
    UINib *messageFromThemNib = [UINib nibWithNibName:@"NPMMessageCellFromThem" bundle:[NSBundle mainBundle]];
    [self.messageTableView registerNib:messageFromMeNib forCellReuseIdentifier:@"messageFromMe"];
    [self.messageTableView registerNib:messageFromThemNib forCellReuseIdentifier:@"messageFromThem"];
}

- (void)setupInsets {
    UIEdgeInsets orig = self.messageTableView.contentInset;
    UIEdgeInsets contentInset = UIEdgeInsetsMake(orig.top, orig.left, orig.bottom + self.messageBarView.frame.size.height, orig.left);
    self.messageTableView.contentInset = contentInset;
    self.messageTableView.scrollIndicatorInsets = contentInset;
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *msg = [messages objectAtIndex:indexPath.row];
    NSString *messageText = [msg objectForKey:@"message"];
    return [NPMMessageCell messageTextViewHeightWithText:messageText];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(NPMMessageCell *)cell updateTextView];
    return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NPMMessageCell *cell;
    PFObject *message = [self.messages objectAtIndex:indexPath.row];
    if ([[message objectForKey:@"fromUsername"] isEqualToString:[[PFUser currentUser] objectForKey:@"username"]]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageFromMe" forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageFromThem" forIndexPath:indexPath];
    }
    cell.message = message;
    return cell;
}

#pragma mark - UITapGestureRecognizer
- (void)setupGestureRecognizer {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tap:)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)tap:(UITapGestureRecognizer *)tapRecognizer {
    [self.messageTextField resignFirstResponder];
}

#pragma mark - TextField Notifications
- (void)setupTextFieldNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self send:nil];
    return YES;
}

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *field = notification.object;
    if ([field.text isEqualToString:@""]) {
        self.sendButton.enabled = NO;
    }
    else {
        self.sendButton.Enabled = YES;
    }
}

#pragma mark - Keyboard Notifications
static inline UIViewAnimationOptions animationOptionsWithCurve(UIViewAnimationCurve curve) {
    return curve << 16;
}

- (void)setupKeyboardNotifications {
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWillShow:)
                                             name:UIKeyboardWillShowNotification
                                           object:nil];
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(keyboardWillHide:)
                                             name:UIKeyboardWillHideNotification
                                           object:nil];
}

- (void)removeKeyboardNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = animationOptionsWithCurve([[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]);
    // compute distance to move
    CGRect endFrame;
    CGRect beginFrame;
    [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&endFrame];
    [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&beginFrame];
    double heightChange = endFrame.origin.y - beginFrame.origin.y;
    CGPoint newCenter = CGPointMake(self.messageBarView.center.x, self.messageBarView.center.y + heightChange);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve
                     animations:^{
                         self.messageBarView.center = newCenter;
                     }
                     completion:^(BOOL done) {
//                         [self.messageBarView removeFromSuperview];
//                         self.messageTextField.inputAccessoryView = self.messageBarView;
                     }
     ];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve
                     animations:^{
                         UIEdgeInsets orig = self.messageTableView.contentInset;
                         UIEdgeInsets contentInsets = UIEdgeInsetsMake(orig.top, orig.left, orig.bottom - heightChange, orig.right);
                         self.messageTableView.contentInset = contentInsets;
                         self.messageTableView.scrollIndicatorInsets = contentInsets;
                     }
                     completion:^(BOOL done){
                         CGSize contSize = self.messageTableView.contentSize;
                         CGRect scrollViewBounds = self.messageTableView.bounds;
                         CGRect frame = CGRectMake(0, contSize.height - 1, scrollViewBounds.size.width, 1);
                         [self.messageTableView scrollRectToVisible:frame animated:YES];
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions curve = animationOptionsWithCurve([[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]);
    // compute distance to move
    CGRect endFrame;
    [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&endFrame];
    CGRect beginFrame;
    [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&beginFrame];
    double heightChange = endFrame.origin.y - beginFrame.origin.y;
    CGPoint newCenter = CGPointMake(self.messageBarView.center.x, self.messageBarView.center.y + heightChange);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve
                     animations:^{
                         self.messageBarView.center = newCenter;
                     }
                     completion:Nil];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:curve
                     animations:^{
                         UIEdgeInsets orig = self.messageTableView.contentInset;
                         UIEdgeInsets contentInsets = UIEdgeInsetsMake(orig.top, orig.left, orig.bottom - heightChange, orig.right);
                         self.messageTableView.contentInset = contentInsets;
                         self.messageTableView.scrollIndicatorInsets = contentInsets;
                     }
                     completion:Nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma - mark Other

- (IBAction)send:(id)sender {
    NSString *messageRaw = self.messageTextField.text;
    if (messageRaw == nil) {
        return;
    }
    NSString *messageBody = [messageRaw stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    PFObject *msgObj = [PFObject objectWithClassName:@"Message"];
    msgObj[@"message"] = messageBody;
    msgObj[@"fromUsername"] = [[PFUser currentUser] objectForKey:@"username"];
    msgObj[@"toUsername"] = self.username;
    msgObj[@"createdDatePosix"] = [[NSString alloc] initWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    self.messageTextField.text = nil;
    [self.navigationController showSGProgressWithDuration:.5 andTintColor:self.navigationController.navigationBar.tintColor andTitle:@"Sending..."];
    [msgObj saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.messages insertObject:msgObj atIndex:self.messages.count];
                [self.messageTableView reloadData];
                // scroll to show new message
                CGSize contSize = self.messageTableView.contentSize;
                CGRect scrollViewBounds = self.messageTableView.bounds;
                CGRect frame = CGRectMake(0, contSize.height, scrollViewBounds.size.width, 1);
                [self.messageTableView scrollRectToVisible:frame animated:YES];
            });
        }
        else {
            NSLog(@"save failed with error: %@", error);
        }
    }];
    }
@end
