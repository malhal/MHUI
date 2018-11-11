//
//  MUIRootMasterDetailSplitViewController.m
//  BigSplit
//
//  Created by Malcolm Hall on 21/08/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIRootMasterDetailSplitViewController.h"
#import "UIViewController+MUI.h"
#import "UIViewController+MUIDetail.h"
#import "MUIRootMasterSplitViewController.h"

#define IS_IPAD_PRO_12_INCH (([UIScreen mainScreen].bounds.size.width == 1366 && [UIScreen mainScreen].bounds.size.height == 1024) || ([UIScreen mainScreen].bounds.size.width == 1024 && [UIScreen mainScreen].bounds.size.height == 1366))

@interface MUIRootMasterDetailSplitViewController() <UISplitViewControllerDelegate>

@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;
@property (strong, nonatomic) MUIRootMasterSplitViewController *rootMasterSplitViewController;

@end

@implementation MUIRootMasterDetailSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible; // these 3 call view did load so dont do it here
    //UINavigationController *nav = self.viewControllers.firstObject;
    self.rootMasterSplitViewController = self.viewControllers.firstObject;//nav.topViewController;
    self.rootMasterSplitViewController.delegate = self;
    //self.rootMasterSplitViewController.view.insetsContentViewsToSafeArea = YES;
    CGSize size = self.view.frame.size;
    [self configureColumnsWithSize:size];
    [self configureTraitsWithSize:size];
    [self updateForcedTraitCollection];
}
//
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    UIEdgeInsets oldSaveArea = self.view.safeAreaInsets; // 44
//    UIEdgeInsets newSafeArea = UIEdgeInsetsZero;
//    // Adjust the safe area to accommodate
//    //  the width of the side view.
//    newSafeArea.left = 55;
////    if let sideViewWidth = sideView?.bounds.size.width {
////        newSafeArea.right += sideViewWidth
////    }
////    // Adjust the safe area to accommodate
////    //  the height of the bottom view.
////    if let bottomViewHeight = bottomView?.bounds.size.height {
////        newSafeArea.bottom += bottomViewHeight
////    }
//    // Adjust the safe area insets of the
//    //  embedded child view controller.
////    let child = self.childViewControllers[0]
//    self.rootMasterSplitViewController.additionalSafeAreaInsets = newSafeArea;
//}

// XS hack for landscape overlay
- (void)viewSafeAreaInsetsDidChange{
    [super viewSafeAreaInsetsDidChange];
    UIEdgeInsets b = self.view.safeAreaInsets;
    UIEdgeInsets newSafeArea = UIEdgeInsetsZero;
    if(b.left){
        newSafeArea.left = b.left + 15;
    }
    self.rootMasterSplitViewController.additionalSafeAreaInsets = newSafeArea;
}

// when in 3 column with no detail item (but has events list) and dragging on messages on to right.
// and with detail iatem and dragging on messages on to right.
//  YES to throwaway master
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    if ([secondaryViewController isKindOfClass:[UINavigationController class]] &&
//        [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[MasterViewController class]] &&
//        ([(MasterViewController *)[(UINavigationController *)secondaryViewController topViewController] masterItem] == nil)) {
//    if(secondaryViewController.mui_masterItem){
//        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//        return NO;
//    }
//    else if([primaryViewController isKindOfClass:[UINavigationController class]] &&
//            [[(UINavigationController *)primaryViewController topViewController] isKindOfClass:[RootViewController class]]){
//        return YES;
//    }
    //else {
        //return YES;
    //}
//    return NO;
    id detailItem = self.mui_detailItem;
    if(!detailItem){
        // If our secondary controller doesn't show a detail item, do the collapse ourself by doing nothing
        return YES;
    }
    else if (![secondaryViewController mui_containsDetailItem:detailItem]) {
        return YES;
    }
    //BOOL result = NO;
    // Malc: when we are in a different folder from the detail we need to throw detail away
//    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
//        UINavigationController *nav = (UINavigationController *)primaryViewController;
//        UIViewController *controller = nav.topViewController;

//    }
    return NO;
}

// This is the inner seperating. called when collapsing from 3 to 1 because traits were changed.
// in from 1 to 3 this needs to be called second to work.
- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    // search for the Master Navigation Controller
//    if([primaryViewController isKindOfClass:UINavigationController.class]){
//       id i = [(UINavigationController *)primaryViewController topViewController];
//       if([i isKindOfClass:UINavigationController.class]){
//           return nil;
//       }
//    //    return nil; // return nil doesn't just do the nav it can also find the preserved controller!
//    }
    // regular call to separateSecondaryViewControllerForSplitViewController on the root finds the detail instead of the master probably because its the top at the time.
 //   if(primaryViewController.mui_masterItem){
        //splitViewController = self;
//        UINavigationController *rootNav = (UINavigationController *)primaryViewController;
//        UIViewController *top = rootNav.topViewController;
//    //    UINavigationController *nc = (UINavigationController *)primaryViewController.childViewControllers.firstObject;
//        id  m = [rootNav separateSecondaryViewControllerForSplitViewController:splitViewController];
//        id i = [m separateSecondaryViewControllerForSplitViewController:splitViewController];
//        if(![i isKindOfClass:NSClassFromString(@"MasterNavigationController")]){
//            NSLog(@"not a MasterNavigationController");
//        }
//        return i; // MasterNavigationController
        
 //       return nil;//UIViewController.alloc.init;
//    }
     return nil;
    
    // need to check if the master nav contains the detail item otherwise we don't keep it
//    return nil;
//    id detailItem = self.mui_detailItem;
//    if(detailItem){
//        UISplitViewController *rootMasterSplitViewController = self.rootMasterSplitViewController;
//        UINavigationController *nav = rootMasterSplitViewController.viewControllers.firstObject;
//        if([nav.topViewController isKindOfClass:UINavigationController.class]){
//            UINavigationController *nav2 = nav.topViewController;
//            UIViewController *vc = nav2.viewControllers.firstObject;
//            if([vc mui_containsDetailItem:detailItem]){
//                return nil;
//            }
//        }
//    }
//    
//    return [splitViewController.storyboard instantiateViewControllerWithIdentifier:@"MasterNavigationController"]; // created twice when going from 1 to 3 (was cause of trait flip, ok now)
}

// when the outer split changes its viewcontrollers it calls overide which causes the inner split to collapse and expand
// however that is necessary to flag the nav as allowing nested.
// no longer needed because we override it?
//    Think it is necessary actually to store the preserved controller so it can be seperated to again.
- (void)setOverrideTraitCollection:(UITraitCollection *)collection forChildViewController:(UIViewController *)childViewController{
    NSLog(@"%@ %@ %@ %@", NSStringFromSelector(_cmd), self, collection, childViewController);
    //if(IS_IPAD_PRO_12_INCH){
        // prevents unnecessry seperate then collapse.
    //    if(collection){
    //        collection = [self checkWithSize:self.view.frame.size];
    //    }else{
    //        UITraitCollection *currentOverride = [self overrideTraitCollectionForChildViewController:childViewController];
            // since the collapse/seperate requires resetting and setting the override we change it to the opposite since we always have it set and thus the events wouldn't fire.
//            if(currentOverride.horizontalSizeClass == UIUserInterfaceSizeClassCompact){
//                collection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
//            }
//            else{
//                collection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
//            }
//        }
//    }
    //[super setOverrideTraitCollection:collection forChildViewController:childViewController];
}

//- (UITraitCollection *)checkWithSize:(CGSize)size{
//
//
//}

- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    super.viewControllers = viewControllers;
    [self updateForcedTraitCollection];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self configureColumnsWithSize:size];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self configureTraitsWithSize:size];
    }];
}

- (void)configureTraitsWithSize:(CGSize)size{
    if(size.width < 1366){
        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
    else{
        self.forcedTraitCollection = nil;//[UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
}

- (void)configureColumnsWithSize:(CGSize)size{
    UISplitViewController *rootMasterSplitViewController = self.rootMasterSplitViewController;
    
    NSLog(@"display modes: %ld %ld", self.displayMode, rootMasterSplitViewController.displayMode);
    // check if we need to go back to 2 columns from 3
    if(size.width < 1366){ // 1280  to allow for other sizes? check ipad mini.
        // Otherwise, compact
        //self.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = UISplitViewControllerAutomaticDimension;
        self.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        self.minimumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = UISplitViewControllerAutomaticDimension;
        //self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
    }
    else{
        // If we are large enough, force a regular size class
       // self.preferredPrimaryColumnWidthFraction = 0.5;
        //rootMasterSplitViewController.preferredPrimaryColumnWidthFraction = 0.5;
        self.maximumPrimaryColumnWidth = 640;//320 * 2;//MAXFLOAT;
        self.minimumPrimaryColumnWidth = 640;//320 * 2;
        //rootMasterSplitViewController.maximumPrimaryColumnWidth = MAXFLOAT;
      //  self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection == forcedTraitCollection) {
        return;
    }
    _forcedTraitCollection = forcedTraitCollection.copy;
    [self updateForcedTraitCollection];
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    //UISplitViewController *splitViewController = self.viewControllers.firstObject;
    id s = self.rootMasterSplitViewController;
    [super setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.rootMasterSplitViewController];
    id i = self.rootMasterSplitViewController.viewControllers.firstObject;
    [self.rootMasterSplitViewController setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:i];
    NSLog(@"");
    
}

// this is the secondary controller.
// called
// by default in compact the detail is pushed on to root instead of master.

// in compact, first time to tap detail there is no detail controller so uses master nav. But after going back and in again it uses detailController which was set to Root.
// calls show on the preservedViewController I think
// check type of sp
// if we don't return YES then it isn't preserved.
/*
 - (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(nullable id)sender{
    return NO;
    UIUserInterfaceSizeClass i = splitViewController.traitCollection.horizontalSizeClass; // regular
    UIUserInterfaceIdiom idiom = UIDevice.currentDevice.userInterfaceIdiom;
    BOOL a = self.isCollapsed;
    BOOL b = splitViewController.isCollapsed;
    
    UINavigationController *nav = (UINavigationController *)vc;
    UIViewController *topViewController = nav.topViewController;
    if(!self.isCollapsed){
        if([topViewController.class mui_doesOverrideViewControllerMethod:@selector(mui_masterItem)]){
            if(!splitViewController.isCollapsed){
                return NO;
            }
        }
        else if([topViewController.class mui_doesOverrideViewControllerMethod:@selector(mui_detailItem)]){
            [self showDetailViewController:vc sender:sender];
            return YES;
        }
        //[splitViewController showDetailViewController:vc sender:sender];
        //return YES;
    }
    // in compact tapping on root item or master item
    
    // doesn't preserve it
    //UINavigationController *rootNavigatonController = splitViewController.viewControllers.firstObject;
    //[rootNavigatonController showViewController:vc sender:sender];
    
    
     //[self showDetailViewController:vc sender:sender];
    //return YES; //return NO; // returning NO when in landscape and root is in overlay does not work for some reason.
    
    return NO;
    if([vc isKindOfClass:NSClassFromString(@"MasterNavigationController")]){
        if(!a){
            if(!b){
                return NO;
            }
            else{
                [splitViewController.viewControllers.firstObject showViewController:vc sender:sender]; // // on big landscape 50:50 split so overlay (for some reason return NO doesnt work in this case).
                return YES;
            }
        }
        return NO;
    }
    else if([vc isKindOfClass:NSClassFromString(@"DetailNavigationController")]){
        BOOL b = splitViewController.isCollapsed;
        if(self.isCollapsed){
             [splitViewController.viewControllers.firstObject showViewController:vc sender:sender]; // todo find the master instead of using the root
            return YES; // 1 column gonig from master to detail, goes wrong
        }
        else{
            [self showDetailViewController:vc sender:sender];
            return YES;
        }
    }
//    if(self.isCollapsed){ // when single column
//        return NO; // returning no can cause the preserved view controller to appear.
//    }
//    else
    if(![vc isKindOfClass:UINavigationController.class]){
        return NO;
    }
    UINavigationController *nc = (UINavigationController *)vc;
    UIViewController *vc2 = nc.topViewController;
    if(![vc2.class mui_doesOverrideViewControllerMethod:@selector(mui_detailItem)]){ // todo improve to search down like targetViewControllerForAction searches up.

        if(splitViewController.isCollapsed){ // i == UIUserInterfaceSizeClassRegular &&
        //    [self showViewController:vc sender:sender]; // for when overlay mode and tap on a root item.
            [self showViewController:vc sender:sender];
            return YES;
        }
        else{
//            [self showDetailViewController:vc sender:sender];
//            return YES;
            return NO;
        }
        
       // return NO;

        
    }else if(self.isCollapsed){
        return NO;
        [self showViewController:vc sender:sender];
        return YES;
    }
    [self showDetailViewController:vc sender:sender];
    return YES;
}
*/



@end
