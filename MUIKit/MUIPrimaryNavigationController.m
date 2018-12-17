//
//  MUIPrimaryNavigationController.m
//  MUIKit
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIPrimaryNavigationController.h"

@interface MUIPrimaryNavigationController ()

@end

@implementation MUIPrimaryNavigationController

// Ensures we only seperate the detail navigation controller. Required when multiple controllers on the primary nav stack.
// The the preserved detail controller will be shown.
-(UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    // how about how many splits is how deep to look for nav controllers?
    UIViewController *viewController = splitViewController.childViewControllers.firstObject;
    // if we have a split as a child we know we need to look one nav controller deep.
    if([viewController isKindOfClass:UISplitViewController.class]){
        return [self.topViewController separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)viewController];
    }
    else if(![self.topViewController isKindOfClass:UINavigationController.class]){ //we keep something that isnt the detail controller?
        return nil;
    }
    return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
}

@end
