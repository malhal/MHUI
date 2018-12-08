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
    if(![self.topViewController isKindOfClass:UINavigationController.class]){
        return nil;
    }
    return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
}

@end
