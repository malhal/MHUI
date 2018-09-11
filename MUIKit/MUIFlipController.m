//
//  MUIFlipController.m
//  MUIKit
//
//  Created by Malcolm Hall on 03/01/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "MUIFlipController.h"
#import <objc/runtime.h>

@interface MUIFlipController()

@property (nonatomic) UIBarButtonItem* flipButton;

@end

@implementation MUIFlipController

- (UIBarButtonItem*)flipButton{
    if(!_flipButton){
        _flipButton = [UIBarButtonItem.alloc initWithTitle:self.titleForFlipButton style:UIBarButtonItemStylePlain target:self action:@selector(flipViewControllers:)];
    }
    return _flipButton;
}

- (NSString*)titleForFlipButton{

    NSString* title = self.selectedViewController.tabBarItem.title;
    if(!title){
        title = @"Flip";
    }
    return title;
}

- (IBAction)flipViewControllers:(id)sender{
    NSUInteger index = self.selectedIndex;
    index++;
    if(index >= self.childViewControllers.count){
        index = 0;
    }
    self.flipButton.title = self.titleForFlipButton;
    
    // get the view controller we will flip to.
    UIViewController* viewController = self.childViewControllers[index];
    
    // allow it to prepare its user interface.
    // also allows the child controller to override viewWillAppear and isMovingToParentViewController will be true which allows them to differentiate
    // between flipping to the controller and navigating back from a child controller presented from within it.
    // isMovingToParentViewController is only set inside the view appear methods.
    [viewController willMoveToParentViewController:self];
    
    // convenience instead of them overriding setSelectedIndex
    // isMovingToParentViewController is not set in here yet.
    [self willFlipToViewController:viewController];
    
    // change tab, view is loaded.
    self.selectedIndex = index;  // calls viewWillAppear, viewDidAppear is called on next event.
    
    [viewController didMoveToParentViewController:self]; // resets isMovingToParentViewController to false for the appear methods.
    
    // flip animation
    [UIView transitionWithView:self.view
                      duration:0.75
                       options:index % 2 ? UIViewAnimationOptionTransitionFlipFromRight : UIViewAnimationOptionTransitionFlipFromLeft
                    animations:nil completion:nil];
}

- (void)willFlipToViewController:(UIViewController*)viewController{
    // default implemetation does nothing.
}

@end


