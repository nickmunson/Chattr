//
//  NPMConversation.h
//  Chattr
//
//  Created by Nick Munson on 9/27/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPMMessage.h"

@interface NPMConversation : NSObject
@property (assign, nonatomic) int nextMsg;
@property (assign, nonatomic) BOOL moreMessages;
@property (strong, nonatomic) NSArray *messages;

- (void)loadMoreMessages;
@end
