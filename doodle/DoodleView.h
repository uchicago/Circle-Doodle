//
//  DoodleView.h
//  doodle
//
//  Created by T. Andrew Binkowski on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoodleView : UIView

@property (assign) CGPoint firstTouch;
@property (assign) CGPoint lastTouch;
@property (strong, nonatomic) UIBezierPath *path;

- (void) clear;

@end
