//
//  NPMChatsTVC.m
//  Chattr
//
//  Created by Nick Munson on 9/17/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMChatsTVC.h"
#import "NPMConvVC.h"
#import "NPMLoginVC.h"
#import <Parse/Parse.h>

@interface NPMChatsTVC () {
    UIAlertView *addFriendAlert;
}

@end

@implementation NPMChatsTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    addFriendAlert = [[UIAlertView alloc] initWithTitle:@"Start a New Chat"
                                                message:@"Enter a username:"
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:@"Chat", nil];
    addFriendAlert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextField = [addFriendAlert textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeAlphabet;
    alertTextField.placeholder = @"username";
    [addFriendAlert textFieldAtIndex:0].delegate = self;
    
    
    _friends = [[PFUser currentUser] objectForKey:@"friends"];
    if (nil == _friends) {
        _friends = [[NSMutableArray alloc] init];
    }
    
}

- (void)logOut:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logOut" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        return _friends.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *username;
    if (tableView == self.tableView) {
        username = [_friends objectAtIndex:indexPath.row];
        cell.textLabel.text = username;
    } else {
        username = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = username;
    }
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)index {
    return YES;
}

#pragma mark - SearchVC

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    self.searchResults = [_friends filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showConv"]) {
        NPMConvVC *convVC = segue.destinationViewController;
        convVC.username = [self.friends objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - Alert Views

- (BOOL)textFieldShouldReturn:(UITextField *)alertTextField {
    [alertTextField resignFirstResponder];
    [addFriendAlert dismissWithClickedButtonIndex:1 animated:YES];
    [self alertView:addFriendAlert clickedButtonAtIndex:1];
    return YES;
}
- (IBAction)addFriend:(id)sender {
    [addFriendAlert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:addFriendAlert.title]) {
        if (buttonIndex == 1) {
            NSString *username = [[alertView textFieldAtIndex:0] text];
            if ([NPMLoginVC isValidUser:username]) {
                if (![_friends containsObject:username]) {
                    if (username) {
                        if (!_friends) {
                            _friends = [[NSMutableArray alloc] init];
                        }
                        [_friends insertObject:username atIndex:0];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        [addFriendAlert textFieldAtIndex:0].text = nil;
                        [[PFUser currentUser] setObject:_friends forKey:@"friends"]; // set friends to updated array
                        [[PFUser currentUser] saveInBackground];
                        [self performSegueWithIdentifier:@"showConv" sender:self];
                    }
                    else
                    {
                        UIAlertView *alert = [NPMLoginVC userNotFoundAlert];
                        alert.delegate = self;
                        [alert textFieldAtIndex:0].text = username;
                        [alert show];
                    }
                }
                else {
                    NSUInteger friendInd = [_friends indexOfObject:username];
                    const NSUInteger indexes[2] = {0,friendInd};
                    NSIndexPath *path = [[NSIndexPath alloc] initWithIndexes:indexes length:2];
                    [self.tableView selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionNone];
                    [self performSegueWithIdentifier:@"showConv" sender:self];
                }
            }
            else {
                UIAlertView *alert = [NPMLoginVC badUserAlert];
                alert.delegate = self;
                [alert show];
            }
        }
        else {
            [addFriendAlert textFieldAtIndex:0].text = nil;
        }
    }
    else {
        [self addFriend:Nil];
    }
}

@end
