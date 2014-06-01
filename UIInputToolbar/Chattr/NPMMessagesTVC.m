//
//  NPMMessagesTVC.m
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMMessagesTVC.h"
#import "NPMMessageCell.h"

@interface NPMMessagesTVC ()

@end

@implementation NPMMessagesTVC
@synthesize messages;

/*
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"in View did load");
    self.messages = [[NSMutableArray alloc] init];
    NSArray *strings = @[@" . . . . . . . . . . . . . . . . . . . . . . . . . . .  |",@"Hi, wasup? Blah, Blah, Blah, Blah...saonhsnoesaonehaosntu,rc.uhsantheutaosheusaon",@"nm, you?",@"same..."];
    for (int i=0; i<[strings count]; i++) {
        NPMMessage *msg = [[NPMMessage alloc] initWithSender:@"me" messageText:[strings objectAtIndex:i]];
        [self.messages addObject:msg];
    }
    NPMMessage *msg = [self.messages objectAtIndex:2];
    msg.sender = @"Michale";
    
    UINib *messageFromMeNib = [UINib nibWithNibName:@"NPMMessageCellFromMe" bundle:[NSBundle mainBundle]];
    UINib *messageFromThemNib = [UINib nibWithNibName:@"NPMMessageCellFromThem" bundle:[NSBundle mainBundle]];

    [self.tableView registerNib:messageFromMeNib forCellReuseIdentifier:@"messageFromMe"];
    [self.tableView registerNib:messageFromThemNib forCellReuseIdentifier:@"messageFromThem"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NPMMessage *msg = [messages objectAtIndex:indexPath.row];
    NSString *messageText = msg.text;
    return [NPMMessageCell messageTextViewHeightWithText:messageText];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(NPMMessageCell *)cell updateTextView];
    return;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPMMessageCell *cell;
    NPMMessage *message = [self.messages objectAtIndex:indexPath.row];
    NSLog(@"in herrrrr");
    NSLog(message);
    if ([message.sender isEqualToString:@"me"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageFromMe" forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"messageFromThem" forIndexPath:indexPath];
    }
    cell.message = message;
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
