//
//  InnerSplitViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 04/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIRootMasterSplitViewController.h"
#import "UIView+MUI.h"
#import "UIViewController+MUI.h"

@interface MUIRootMasterSplitViewController ()

@property (assign, nonatomic) BOOL overlayFix;

@end

@implementation MUIRootMasterSplitViewController

// decides if showDetailViewController should be passed up to the outer split, e.g. if choosing a detail item on the master
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action == @selector(showDetailViewController:sender:)){
        UIViewController *viewController;
        if([sender isKindOfClass:UIView.class]){
            UIView *view = (UIView *)sender;
            viewController = view.mui_viewController;
        }
        else if([sender isKindOfClass:UIViewController.class]){
            viewController = (UIViewController *)sender;
        }
        UIViewController *vc = viewController.navigationController;
        if(vc != self.rootNavigationController){ // for 3 column tapping middle column.
        //if([viewController isKindOfClass:NSClassFromString(@"MasterViewController")]){
//        if([viewController.class mui_doesOverrideViewControllerMethod:@selector(mui_masterItem)]){ // means it came from the master so must be showing the detail. Master must be the last possible view controller before master
           // BOOL c = self.isCollapsed;
            return NO; // need to say no so it goes up to outer split so it can preserve it and then it calls show on the inner which pushes onto its child.
            //return YES;
        }
    }
    return [super canPerformAction:action withSender:sender];
}

- (UINavigationController *)rootNavigationController{
    return self.viewControllers.firstObject;
}

- (UINavigationController *)masterNavigationController{
    return (UINavigationController *)self.rootNavigationController.topViewController;
}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    [self.masterNavigationController showViewController:vc sender:sender];
}

- (UITraitCollection *)traitCollection{
    UITraitCollection *traitCollection = super.traitCollection;
    if(self.overlayFix){
        traitCollection = [UITraitCollection traitCollectionWithTraitsFromCollections:@[traitCollection, [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact]]];
    }
    return traitCollection;
}

- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender{
    if(self.splitViewController.displayMode == UISplitViewControllerDisplayModePrimaryOverlay){
        self.overlayFix = YES;
    }
    [super showDetailViewController:vc sender:sender];
    self.overlayFix = NO;
}

- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
    [self.masterNavigationController collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
}

- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    return [self.masterNavigationController separateSecondaryViewControllerForSplitViewController:splitViewController];
}

@end
