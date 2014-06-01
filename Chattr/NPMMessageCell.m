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

@end
