//
//  NPMMessageBarView.m
//  Chattr
//
//  Created by Nick Munson on 11/19/13.
//  Copyright (c) 2013 munson.nick. All rights reserved.
//

#import "NPMMessageBarView.h"

@implementation NPMMessageBarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // make path
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0.25);
    CGContextAddLineToPoint(ctx, self.bounds.size.width, 0.25);
    CGContextClosePath(ctx);
    // set options
    CGContextSetLineWidth(ctx, .5);
    CGFloat colorComponents[4] = {0, 0, 0, .3};
    CGContextSetStrokeColor(ctx, colorComponents);
    CGContextStrokePath(ctx);
}

@end
