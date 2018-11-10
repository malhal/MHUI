//
//  MUIDetailSplitter.m
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIDetailSplitter.h"
#import "UIViewController+MUIDetail.h"

@implementation MUIDetailSplitter

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitController{
    self = [super init];
    if (self) {
        splitController.delegate = self;
        _splitController = splitController;
    }
    return self;
}

// needs tested
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    id detailItem = secondaryViewController.mui_detailItem;
    if(!detailItem){
        // If our secondary controller doesn't show a detail item, do the collapse ourself by doing nothing
        return YES;
    }
    // Before collapsing, remove any view controllers on our stack that don't match the photo we are about to merge on
    // Malc: this is for when the table isnt showing the selected photo, i.e. in a different folder.
    if(![primaryViewController isKindOfClass:[UINavigationController class]]) {
        return YES;
    }
    UINavigationController *nc = (UINavigationController *)primaryViewController;
    if(nc.viewControllers.count == 1){
        return YES;
    }
    for (UIViewController *controller in nc.viewControllers) {
        if (![controller mui_containsDetailItem:detailItem]) {
            return YES;
        }
    }
    return NO;
}

- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    if(primaryViewController.mui_detailItem){
        // Do the standard behavior if we have a photo
        return nil;
    }
    return [self.delegate createDetailViewControllerForDetailSplitter:self];
}

@end
