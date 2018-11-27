//
//  UIViewController+MUIDetail.m
//  MUIKit
//
//  Created by Malcolm Hall on 31/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MUIDetail.h"

@implementation UIViewController (MUIDetail)

- (id)mui_masterItem
{
    return nil;
}

- (BOOL)mui_containsMasterItem:(id)masterItem{
    return NO;
}

- (id)mui_detailItem
{
    // By default, view controllers don't contain photos
    return nil;
}

- (BOOL)mui_containsDetailItem:(id)detailItem
{
    // By default, view controllers don't contain photos
    return NO;
}

// Malc: visible is a key detail here because targetViewControllerForAction doesn't work if view controller isn't showing, e.g. was just popped.
- (id)mui_currentVisibleDetailItemWithSender:(id)sender
{
    // Look for a view controller that has a visible photo
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentVisibleDetailItemWithSender:) sender:sender];
    if (target) {
        return [target mui_currentVisibleDetailItemWithSender:sender];
    } else {
        return nil;
    }
}

@end

@implementation UISplitViewController (MUIDetail)

- (id)mui_currentVisibleDetailItemWithSender:(id)sender
{
    if (self.collapsed) {
        // If we're collapsed, we don't have a detail
        return nil;
    } else {
        // Otherwise, return our detail controller's contained photo (if any)
        UIViewController *controller = self.viewControllers.lastObject;
        return [controller mui_detailItem];
        //return [controller mui_currentVisibleDetailItemWithSender:sender]; // maybe odd we call this on a nav controller that just said it couldn't perform the action.
    }
}

- (id)mui_masterItem
{
    id masterItem;
    for(UIViewController *controller in self.viewControllers){
        if((masterItem = controller.mui_masterItem)){
            break;
        }
    }
    return masterItem;
}

- (BOOL)mui_containsMasterItem:(id)masterItem{
    return [self.viewControllers.firstObject mui_containsMasterItem:masterItem];
}

- (id)mui_detailItem
{
    id detailItem;
    for(UIViewController *controller in self.viewControllers){
        if((detailItem = controller.mui_detailItem)){
            break;
        }
    }
    return detailItem;
}

- (BOOL)mui_containsDetailItem:(id)detailItem
{
    return [self.viewControllers.firstObject mui_containsDetailItem:detailItem];
}

@end

@implementation UINavigationController (MUIDetail)

- (id)mui_masterItem
{
    id masterItem;
    for(UIViewController *controller in self.viewControllers){
        if((masterItem = controller.mui_masterItem)){
            break;
        }
    }
    return masterItem;
}

- (BOOL)mui_containsMasterItem:(id)masterItem
{
    return [self.topViewController mui_containsMasterItem:masterItem];
}

// added this because our detail is a nav.
// used by above method and also app delegate to find the detail item within a nav controllers and nested ones.
// def needs tested for triple split.
- (id)mui_detailItem
{
    id detailItem;
    for(UIViewController *controller in self.viewControllers){
        if((detailItem = controller.mui_detailItem)){
            break;
        }
    }
    return detailItem;
}

- (BOOL)mui_containsDetailItem:(id)detailItem
{
    return [self.topViewController mui_containsDetailItem:detailItem];
}

@end


