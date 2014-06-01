//
//  NPMUser.h
//  Chattr
//
//  Created by Nick Munson on 9/18/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPMBackendTools.h"

@interface NPMUser : NSObject
@property (strong, nonatomic) NSString *username;
@property (assign, nonatomic) char *encryptedUsername;
@property (assign, nonatomic) char *pubkey;

- (NPMUser *)initWithUsername:(NSString *)username;

@end