//
//  NPMMessage.m
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMMessage.h"

@implementation NPMMessage
@synthesize text,sender,attachment;

- (NPMMessage *)initWithSender:(NSString *)theSender messageText:(NSString *)theText {
    self = [super init];
    self.sender = theSender;
    self.text = theText;
    return self;
}

@end
