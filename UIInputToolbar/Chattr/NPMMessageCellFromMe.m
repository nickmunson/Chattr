//
//  NPMMessageCellFromMe.m
//  Chattr
//
//  Created by Nick Munson on 9/30/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMMessageCellFromMe.h"

@implementation NPMMessageCellFromMe

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.messageTextView.textColor = [UIColor whiteColor];
    }
    return self;
}

- (void)updateTextView {
    [super updateTextView];
    self.messageTextView.textAlignment = NSTextAlignmentRight;
    self.messageTextView.textColor = [UIColor whiteColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
