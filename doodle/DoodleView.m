//
//  DoodleView.m
//  doodle
//
//  Created by T. Andrew Binkowski on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DoodleView.h"

@implementation DoodleView
@synthesize firstTouch,lastTouch;
@synthesize path;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
	path = [UIBezierPath bezierPath];	
	path.lineWidth = 15.0f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
	
	UITouch *touch = [touches anyObject];
	[path moveToPoint:[touch locationInView:self]];
}

- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
	UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
	[self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self touchesEnded:touches withEvent:event];
}

- (void) clear 
{
    NSLog(@"Clear");
    [path removeAllPoints];
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
	[[UIColor blueColor] set];
	[path stroke];
}
@end
