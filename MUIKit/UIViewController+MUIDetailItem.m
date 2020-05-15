//
//  UIViewController+MUIDetailItem.m
//  MUIKit
//
//  Created by Malcolm Hall on 30/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MUIDetailItem.h"

@implementation UIViewController (MUIDetailItem)

- (id)mui_containedDetailItem{
  //  return objc_getAssociatedObject(self, @selector(mui_detailItem));
    return nil;
}

- (BOOL)mui_containsDetailItem:(id)object{
    return NO;
}

//- (UIBarButtonItem *)mui_currentDisplayModeButtonItemWithSender:(id)sender{
//    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentDisplayModeButtonItemWithSender:) sender:sender];
//    if (target) {
//        return [target mui_currentDisplayModeButtonItemWithSender:sender];
//    } else {
//        return nil;
//    }
//}

//- (void)mui_showDetailDetailViewController:(UIViewController *)vc sender:(id)sender{
//    UIViewController *target = [self targetViewControllerForAction:@selector(mui_showDetailDetailViewController:sender:) sender:sender];
//    if (target) {
//        [target mui_showDetailDetailViewController:vc sender:sender];
//    }
//}
//
//- (id)mui_detailDetailItem{
//    return nil;
//}
//
//- (BOOL)mui_canSelectDetailDetailItem:(id)object{
//    return NO;
//}

//- (id)mui_currentVisibleDetailItemWithSender:(id)sender
//{
//    // Look for a view controller that has a visible photo
//    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentVisibleDetailItemWithSender:) sender:sender];
//    if (target) {
//        return [target mui_currentVisibleDetailItemWithSender:sender];
//    } else {
//        return nil;
//    }
//}

//- (UINavigationController *)mui_masterNavigationController{
//    return nil;
//}

- (UIViewController *)mui_currentVisibleDetailViewControllerWithSender:(id)sender{
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentVisibleDetailViewControllerWithSender:) sender:sender];
    if (target) {
        return [target mui_currentVisibleDetailViewControllerWithSender:sender];
    } else {
        return nil;
    }
}

@end


@implementation UINavigationController (MUIDetailItem)

- (BOOL)mui_containsDetailItem:(id)object{
    return [self.topViewController mui_containsDetailItem:object];
}

- (id)mui_containedDetailItem{
//    if([self.topViewController isKindOfClass:UINavigationController.class]){
//        return self.topViewController.mui_containedDetailItem;
//    }
//    else{
    return self.viewControllers.firstObject.mui_containedDetailItem; // e.g. end nav controller's end VC's item.
   // }
}


//- (BOOL)mui_canSelectDetailDetailItem:(id)object{
//    return [self.topViewController mui_canSelectDetailDetailItem:object];
//}

//- (id)mui_detailDetailItem{
//    if([self.topViewController isKindOfClass:UINavigationController.class]){
//        return self.topViewController.mui_detailDetailItem;
//    }
//    else{
//        return self.viewControllers.firstObject.mui_detailDetailItem;
//    }
//}   


@end

@implementation UISplitViewController (MUIDetailItem)

//- (UINavigationController *)mui_masterNavigationController{
//    if([self.viewControllers.firstObject isKindOfClass:UINavigationController.class]){
//        return self.viewControllers.firstObject;
//    }
//}


- (UIViewController *)mui_currentVisibleDetailViewControllerWithSender:(id)sender{
    if(self.viewControllers.count < 2){
        return nil;
    }
    return self.viewControllers.lastObject;
}

- (BOOL)mui_containsDetailItem:(id)object{
    return [self.viewControllers.firstObject mui_containsDetailItem:object];
}

//- (id)mui_currentVisibleDetailItem{ // WithSender:(id)sender
    //if (self.collapsed) { // didnt work in 1 to 3 collumn
//    if(self.viewControllers.count == 1){
        // If we're collapsed, find the detail nav controller
      //  UINavigationController *nav = self.viewControllers.firstObject;
//        if([self.topViewController isKindOfClass:UINavigationController.class]){
//            return self.topViewController.mui_containedDetailItem;
//        }
        
//        UINavigationController *senderNav = [sender navigationController];
//        UINavigationController *outermost = senderNav;
//        if(outermost.navigationController){
//            outermost = outermost.navigationController;
//        }
        
        // find the master nav controller
        
  //      return nil;
//    } else {
//        // Otherwise, return our detail controller's contained photo (if any)
//        UINavigationController *nc = self.viewControllers.lastObject;
//        UIViewController *controller = nc.viewControllers.firstObject;
//        return controller.mui_containedDetailItem;
//    }
//}

//- (UIBarButtonItem *)mui_currentDisplayModeButtonItemWithSender:(id)sender{
//    return self.displayModeButtonItem;
//}

//- (id)mui_containedDetailItem{
//    return self.viewControllers.firstObject.mui_containedDetailItem;
//}

//- (id)mui_detailDetailItem{
//    return self.viewControllers.firstObject.mui_detailDetailItem;
//}

@end
