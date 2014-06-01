//
//  NPMUser.m
//  Chattr
//
//  Created by Nick Munson on 9/18/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMUser.h"

@implementation NPMUser

@synthesize username,encryptedUsername,pubkey;

// will check with server for valid username and get pubkey and encrypted name
// returns nil if username not found/error occured
- (NPMUser *)initWithUsername:(NSString *)uname {
    self = [super init];
    self.username = uname;
    self.encryptedUsername = '\0';
    self.pubkey = '\0';
    return self;
}

- (NSString *)description {
    return self.username;
}

@end
