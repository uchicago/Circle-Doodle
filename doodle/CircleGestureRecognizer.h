//
//  CircleGestureRecognizer.h
//  doodle
//
//  Created by T. Andrew Binkowski on 11/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

#define DX(p1, p2)	(p2.x - p1.x)
#define DY(p1, p2)	(p2.y - p1.y)
#define SIGN(NUM) (NUM < 0 ? (-1) : 1)
#define POINT(X)	[[points objectAtIndex:X] CGPointValue]


@interface CircleGestureRecognizer : UIGestureRecognizer

@property (strong, nonatomic) NSDate *firstTouchDate;
@property (strong, nonatomic) NSMutableArray *points;

float distance (CGPoint p1, CGPoint p2);
CGRect boundingRect(NSArray *points);
CGPoint getRectCenter(CGRect rect);
CGRect testForCircle(NSArray *points, NSDate *firstTouchDate);
@end
