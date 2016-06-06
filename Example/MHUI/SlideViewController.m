//
//  ViewController.m
//  SlideViewAnimation
//
//  Created by Malcolm Hall on 18/04/2016
//  Copyright (c) 2016 Malcolm Hall. All rights reserved.
//

#import "SlideViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SlideViewController ()
@property (assign) NSInteger runningAnimations;

@end

@implementation SlideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //_RectView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CABasicAnimation*)newTransition{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;//kAnimationDuration
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.delegate = self;
    NSLog(@"%@", _RectView.layer.presentationLayer);
    
//    CABasicAnimation* theAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
//    theAnimation.duration=0.5;
//    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    theAnimation.fromValue= [NSNumber numberWithFloat:_RectView.bounds.size.height];
//    theAnimation.toValue= @0;
    
    
    return transition;
}

-(void)viewSlideInFromRightToLeft:(UIView *)view
{
    [view mhu_transitionSlide:MHViewAnimationTransitionSlideToFromRight completion:nil];
}

-(void)viewSlideInFromLeftToRight:(UIView *)view
{
    [view mhu_transitionSlide:MHViewAnimationTransitionSlideToFromLeft completion:nil];
}


-(void)viewSlideInFromTopToBottom:(UIView *)view
{
    [view mhu_transitionSlide:MHViewAnimationTransitionSlideToFromTop completion:nil];
}

-(void)viewSlideInFromBottomToTop:(UIView *)view
{
    [view mhu_transitionSlide:MHViewAnimationTransitionSlideToFromBottom completion:nil];
}

- (IBAction)animateRight:(id)sender {
   
    [self viewSlideInFromLeftToRight:_RectView];
}

- (IBAction)animateLeft:(id)sender {
    [self viewSlideInFromRightToLeft:_RectView];
}

- (IBAction)animateDown:(id)sender {
    [self viewSlideInFromTopToBottom:_RectView];
}

- (IBAction)animateUp:(id)sender {
    [self viewSlideInFromBottomToTop:_RectView];
}
@end
