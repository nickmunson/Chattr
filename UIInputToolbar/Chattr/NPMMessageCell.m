//
//  NPMMessageCell.m
//  Chattr
//
//  Created by Nick Munson on 9/22/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMMessageCell.h"

@implementation NPMMessageCell
@synthesize messageTextView, message;

static const CGFloat WIDTH = 320.0;

int TEXT_PADDING = 7.0;

+ (UIFont *)messageTextViewFont {
    return [UIFont systemFontOfSize:16.0];
}

+ (CGFloat)messageTextViewHeightWithText:(NSString *)text {
    UIFont *font = [NPMMessageCell messageTextViewFont];
    CGRect rect = [text boundingRectWithSize:CGSizeMake(WIDTH - (2 * TEXT_PADDING), CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin // | NSStringDrawingUsesFontLeading
                                  attributes:@{NSFontAttributeName: font}
                                     context:nil];
    NSLog(@"%f",rect.size.height + (2 * TEXT_PADDING));
    return rect.size.height + (2 * TEXT_PADDING);
}

- (void)updateTextView {
    self.messageTextView.text = [self.message objectForKey:@"message"];
    self.messageTextView.font = [NPMMessageCell messageTextViewFont];
    self.messageTextView.textContainer.lineFragmentPadding = 0;
    self.messageTextView.textContainerInset = UIEdgeInsetsMake(TEXT_PADDING,TEXT_PADDING,TEXT_PADDING,TEXT_PADDING);
}

/*
+ (CGFloat)messageTextViewWidth {
    return 255.0;
}

+ (UIColor *)myColor {
    return [UIColor whiteColor];
}

+ (UIColor *)theirColor {
    return [UIColor lightGrayColor];
}

+ (CGPoint)messageTextViewmyOrigin {
    return CGPointMake(65.0, 0.0);
}

+ (CGPoint)messageTextViewTheirOrigin {
    return CGPointMake(0.0, 00.0);
}

+ (NSLineBreakMode *)messageTextViewLineBreakMode {
    return NSLineBreakByWordWrapping;
}
*/

/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        messageTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [NPMMessageCell messageTextViewWidth], 600)];
            // BAD Hard Coded value 600 will cut content on large messages
        messageTextView.editable = NO;
        messageTextView.hidden = NO;
        messageTextView.dataDetectorTypes = UIDataDetectorTypeAll;
        messageTextView.backgroundColor = [UIColor clearColor];
        messageTextView.contentMode = UIViewContentModeRedraw;
        messageTextView.scrollEnabled = NO;
        [self.contentView addSubview:messageTextView];
    }
    return self;
}
*/


/*
 {
    if ([message.sender isEqualToString:@"me"]) {
        self.backgroundColor = [NPMMessageCell myColor];
        self.messageTextView.textAlignment = NSTextAlignmentRight;
        
        CGRect newFrame = self.messageTextView.frame;
        newFrame.origin = [NPMMessageCell messageTextViewmyOrigin];
        self.messageTextView.frame = newFrame;
        
        [self.messageTextView setText: message.text];
        self.messageTextView.font = [NPMMessageCell messageTextViewFont];
    }
    else {
        self.backgroundColor = [NPMMessageCell theirColor];
        
        CGRect newFrame = self.messageTextView.frame;
        newFrame.origin = [NPMMessageCell messageTextViewTheirOrigin];
        self.messageTextView.frame = newFrame;
        self.messageTextView.text = message.text;
        self.messageTextView.font = [NPMMessageCell messageTextViewFont];
    }
}
 */

@end
