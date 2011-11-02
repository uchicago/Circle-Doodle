//
//  HomeViewController.m
//  doodle
//
//  Created by T. Andrew Binkowski on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "DoodleView.h"
#import "CircleGestureRecognizer.h"

@implementation HomeViewController
@synthesize doodleView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect window = [[UIScreen mainScreen] bounds];
    self.doodleView = [[DoodleView alloc] initWithFrame:window];

    CircleGestureRecognizer *recognizer = [[CircleGestureRecognizer alloc] initWithTarget:self action:@selector(handleCircleRecognizer:)]; 
	[self.doodleView addGestureRecognizer:recognizer];
    
    [self.view addSubview:self.doodleView];
}

- (void) handleCircleRecognizer:(UIGestureRecognizer *) recognizer
{
	// Respond to a recognition event by updating the background
	NSLog(@"Circle recognized");
	//self.view.backgroundColor = [UIColor randomColor];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Shake
- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //if (motion != UIEventSubtypeMotionShake) return; 
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventTypeMotion && event.type == UIEventSubtypeMotionShake) {
        NSLog(@"Motion Ended on %@", [NSDate date]);
        [self.doodleView clear];
    }
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {}

@end
