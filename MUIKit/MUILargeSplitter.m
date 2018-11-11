//
//  MUILargeDetailSplitter.m
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUILargeSplitter.h"
#import "UIViewController+MUIDetail.h"
#import "MUIRootMasterDetailSplitViewController.h"

@implementation MUILargeSplitter

- (instancetype)initWithLargeSplitViewController:(MUIRootMasterDetailSplitViewController *)splitController{
    self = [super init];
    if (self) {
        splitController.delegate = self;
        _splitController = splitController;
    }
    return self;
}

// needs to push detail onto the root nav controller (not the master).
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    // here we are deciding if the detail should be thrown away or not. Based on if the current controllers contain it.
    
    id detailItem = secondaryViewController.mui_detailItem;
    if(!detailItem){
        // If our secondary controller doesn't show a detail item, do the collapse ourself by doing nothing
        return YES;
    }
    primaryViewController = ((UISplitViewController *)primaryViewController).viewControllers.firstObject;
        // Before collapsing, remove any view controllers on our stack that don't match the photo we are about to merge on
        // Malc: this is for when the table isnt showing the selected photo, i.e. in a different folder.
    if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)primaryViewController;
//        if(nav.viewControllers.count == 1){
//            return YES;
//        }
        for (UIViewController *controller in nav.viewControllers) {
            if ([controller isKindOfClass:UINavigationController.class]) {
                for (UIViewController *controller2 in [(UINavigationController *)controller viewControllers]) {
                    if (![controller2 mui_containsDetailItem:detailItem]) {
                        return YES;
                    }
                }
                //[(UINavigationController *)primaryViewController setViewControllers:viewControllers];
                //continue;
            }
            else if (![controller mui_containsDetailItem:detailItem]) {
                return YES;
            }
        }
        //[(UINavigationController *)primaryViewController setViewControllers:viewControllers];
    }
    return NO;
    
    //if(primaryViewController.mui_masterItem && secondaryViewController.mui_detailItem){
        // forward this onto the navigation controller
       // UISplitViewController *sv = (UISplitViewController *)primaryViewController;
       // UINavigationController *nc = sv.viewControllers.firstObject;
       // UINavigationController *nc2 = (UINavigationController *)nc.topViewController; // MasterNavigationController
        
        // needs to take the detail from right and push it onto the root nav controller.
        
       // [nc collapseSecondaryViewController:secondaryViewController forSplitViewController:splitViewController];
//        return NO;
//    }
//    else{
//        return YES;
//    }
    
}

// needs to be called first
// large splitter seperating
- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    // need to handle 12" portrait in compact on left with safari on right to full screen.
    // this is called after the other seperate.
    
    // Needs to find the submaster in either the secondary master 2 deep or the top of the secondary detail.
    
    //    UISplitViewController *split = (UISplitViewController *)primaryViewController;
    //    UIViewController *vc = split.viewControllers.lastObject;
    //    while([vc isKindOfClass:UINavigationController.class]){
    //        UINavigationController *nav = (UINavigationController *)vc;
    //        if([nav isKindOfClass:MasterNavigationController.class]){
    //            return [nav separateSecondaryViewControllerForSplitViewController:splitViewController];
    //        }
    //        vc = nav.topViewController;
    //    }
    
    //    else if(![vc isKindOfClass:UINavigationController.class]){
    //        return NO;
    //    }
    //    UINavigationController *nc = (UINavigationController *)vc;
    //    if(![nc.topViewController.class mui_doesOverrideViewControllerMethod:@selector(mui_detailItem)]){ // todo improve to search down like targetViewControllerForAction searches up.
    //        return NO;
    //    }
    
    //    if([nav isKindOfClass:MasterNavigationController.class]){
    //        MasterNavigationController = nav; // this was just created by the secondary split when seperating from 1 to 3.
    //    }
    //    else{
    //        UIViewController *vc = nav.topViewController;
    //        if([vc isKindOfClass:MasterNavigationController.class]){
    //            MasterNavigationController = (MasterNavigationController *)vc;
    //        }
    //    }
    //    if(MasterNavigationController){
    //        return [MasterNavigationController separateSecondaryViewControllerForSplitViewController:splitViewController];
    //    }
//    if(primaryViewController.mui_masterItem){
//        UISplitViewController *sv = (UISplitViewController *)primaryViewController;
//        UINavigationController *nc = sv.viewControllers.firstObject;
//      //     nc = (UINavigationController *)nc.topViewController;
//        UIViewController *vc = [nc separateSecondaryViewControllerForSplitViewController:sv];
//        return vc;
//    }
//    else
//    return nil;
//    BOOL a = splitViewController.isCollapsed; // NO from 1 to 2, and from 1 to 3
//    if(primaryViewController.mui_detailItem){
//        // Do the standard behavior if we have a photo
//        UISplitViewController *sv = (UISplitViewController *)primaryViewController;
//        UINavigationController *nc = sv.viewControllers.firstObject; // not first object
//        UINavigationController *nc2 = nc.childViewControllers.firstObject; // not first object
//
//        UIViewController *vc = [nc2 separateSecondaryViewControllerForSplitViewController:sv];
//        NSAssert(vc, @"vc can't be nil");
//
//        return vc;  // must be detail navigation controller
//       // return nil;//UIViewController.alloc.init;
//    }
//
    
    if(primaryViewController.mui_detailItem){
        return nil;
    }
    
    return [self.delegate createDetailNavigationControllerForLargeSplitter:self];
}

//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showViewController:(UIViewController *)vc sender:(nullable id)sender{
//    UISplitViewController *sv = (UISplitViewController *)splitViewController.viewControllers.firstObject;
//    UINavigationController *nc = sv.viewControllers.firstObject;
////    nc = (UINavigationController *)nc.topViewController;
//    [nc showViewController:vc sender:sender];
//    return YES;
//}
//
//- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(nullable id)sender{
//    NSLog(@"");
//    return YES;
//}

@end
