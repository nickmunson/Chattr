//
//  NPMBackendTools.h
//  Chattr
//
//  Created by Nick Munson on 9/18/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NPMUser.h"

@class NPMUser;

// change to NPMBackendManager and instantiate, passing referance between View Controllers
@interface NPMBackendTools : NSObject
// static methods is temporary, just for writing UI/Backend interface
+ (BOOL)addUser:(NPMUser *)user; // Puts user info in database. Returns false if unsuccessful
+ (BOOL)removeUser:(NPMUser *)user;

@end
