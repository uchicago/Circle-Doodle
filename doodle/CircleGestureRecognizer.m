//
//  CircleGestureRecognizer.m
//  doodle
//
//  Created by T. Andrew Binkowski on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CircleGestureRecognizer.h"

@implementation CircleGestureRecognizer

@synthesize points;
@synthesize firstTouchDate;

/*******************************************************************************
 * @method          reset
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)reset
{
	[super reset];
	
	points = nil;
	firstTouchDate = nil;
	self.state = UIGestureRecognizerStatePossible;
}

/*******************************************************************************
 * @method          touchesBegan
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	
	if (touches.count > 1) 
	{
		self.state = UIGestureRecognizerStateFailed;
		return;
	}
	
	points = [NSMutableArray array];
	firstTouchDate = [NSDate date];
	UITouch *touch = [touches anyObject];
	[points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];	
}

/*******************************************************************************
 * @method          <# Method Name #>
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	[points addObject:[NSValue valueWithCGPoint:[touch locationInView:self.view]]];	
}

/*******************************************************************************
 * @method          <# Method Name #>
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent: event];
	BOOL detectionSuccess = !CGRectEqualToRect(CGRectZero, testForCircle(points, firstTouchDate));
	if (detectionSuccess)
		self.state = UIGestureRecognizerStateRecognized;
	else
		self.state = UIGestureRecognizerStateFailed;
}


#pragma mark Geometry Utilities
/*******************************************************************************
 * @method          getRectCenter
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
CGPoint getRectCenter(CGRect rect) {
	return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}


/*******************************************************************************
 * @method          distance
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
float distance (CGPoint p1, CGPoint p2)
{
	float dx = p2.x - p1.x;
	float dy = p2.y - p1.y;
	
	return sqrt(dx*dx + dy*dy);
}

// Calculate and return least bounding rectangle
/*******************************************************************************
 * @method          boundingRect
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
CGRect boundingRect(NSArray *points)
{
	CGRect rect = CGRectZero;
	CGRect ptRect;
	
	for (int i = 0; i < points.count; i++)
	{
        CGPoint pt = POINT(i);
		ptRect = CGRectMake(pt.x, pt.y, 0.0f, 0.0f);
		rect = (CGRectEqualToRect(rect, CGRectZero)) ? ptRect : CGRectUnion(rect, ptRect);
	}
	
	return rect;
}

#pragma mark Circle Detection
/*******************************************************************************
 * @method          testForCircle
 * @abstract        <# Abstract #>
 * @description     <# Description #>
 ******************************************************************************/
CGRect testForCircle(NSArray *points, NSDate *firstTouchDate)
{
	if (points.count < 2) {
		if (DEBUG) NSLog(@"Too few points (2) for circle");
		return CGRectZero;
	}
    
	// The start and end points must be between some number of points of each other
	float tolerance = [[[UIApplication sharedApplication] keyWindow] bounds].size.width / 3.0f;	
	if (distance(POINT(0), POINT(points.count - 1)) > tolerance) {
		if (DEBUG) NSLog(@"Start and end points too far apart. Fail.");
		return CGRectZero;
	}
	CGRect circle = boundingRect(points); 
	//CGPoint center = getRectCenter(circle);
	return circle;
}

@end
