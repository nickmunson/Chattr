//
//  NPMMessage.h
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPMMessage : NSObject

@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) id attachment;

- (NPMMessage *)initWithSender:(NSString *)theSender messageText:(NSString *)theText;
@end