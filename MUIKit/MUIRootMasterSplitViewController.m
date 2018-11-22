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
@property (strong, nonatomic, readonly) UIViewController *masterViewController;
@property (assign, nonatomic) UIViewController *preservedDetailViewController;

@end

@interface UINavigationController()

- (void)_safeAreaInsetsDidChangeForView;

@end

@implementation MUIRootMasterSplitViewController
@dynamic masterViewController;

- (NSString *)title{
    return self.masterViewController.title;
}

// decides if showDetailViewController should be passed up to the outer split, e.g. if choosing a detail item on the master
// the reason we handle it this way is so the outer split can preserve it. Then it calls show on us and we push it.
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if(action == @selector(showDetailViewController:sender:)){
        UIViewController *vc = [self childContainingSender:sender];
        // if showDetail came from the detail then we pass it up the chain.
        if(vc != self.masterViewController){
            return NO;
        }
    }
    return [super canPerformAction:action withSender:sender];
}

- (UIViewController *)childContainingSender:(id)sender{
    // check the detail first because when collapsed the sender will also be in the master's hierarchy.
    UIViewController *vc = self.preservedDetailViewController;
    BOOL b = [sender mui_isMemberOfViewControllerHierarchy:vc];
    if(b){
        return vc;
    }
    vc = self.masterViewController;
    b = [sender mui_isMemberOfViewControllerHierarchy:vc];
    if(b){
        return vc;
    }
    return nil;
}

//- (UINavigationController *)rootNavigationController{
//    //return self.viewControllers.firstObject;
//    return self.masterViewController;
//}

//- (UINavigationController *)masterNavigationController{
//    //return (UINavigationController *)self.rootNavigationController.topViewController;
//    UIViewController *masterViewController = self.childViewControllers.firstObject; // or self.masterViewController (private)
//    return MHFDynamicCast(UINavigationController.class, masterViewController);
//}

//- (UINavigationController *)nestedDetailNavigationController{
//    return MHFDynamicCast(UINavigationController.class, self.masterNavigationController.topViewController);
//}

//- (UINavigationController *)detailNavigationController{
//    UIViewController *detailViewController = nil;
//    if(!self.isCollapsed){
//        id i = self.childViewControllers.lastObject;
//        id j = self.preservedDetailViewController;
//        return i;
//    }
//    return self.preservedDetailViewController;
//    UIViewController *masterViewController = self.masterViewController;
//    if(masterViewController.childViewControllers.count){
//        vc = masterViewController.childViewControllers.lastObject;
//    }
//    if(!vc.childViewControllers.count){
//        return nil;
//    }
//        detailViewController = vc;
//    }else{
//        detailViewController = ;
//    }
//    id j = i.childViewControllers;
//    if(!self.isCollapsed && self.viewControllers.count > 1){ // in 3 column mode
//        vc = self.viewControllers[1];
//    }
//    else{
//        //vc = self.masterNavigationController.topViewController; // we rely on next check of it being a nav controller
//
//        NSLog(@"");
//
//    }
//    return MHFDynamicCast(UINavigationController.class, vc);
    //return detailViewController;
//}

- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    [self.masterViewController showViewController:vc sender:sender];
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
    self.preservedDetailViewController = vc;
    self.overlayFix = NO;
}

// from 3 to 2 or 1 columns
- (void)collapseSecondaryViewController:(UIViewController *)secondaryViewController forSplitViewController:(UISplitViewController *)splitViewController{
    [self.masterViewController collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
}

// from 1 to 2 or 3 columns
- (nullable UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    return [self.masterViewController separateSecondaryViewControllerForSplitViewController:splitViewController];
}

@end
