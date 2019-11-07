//
//  UIViewController+MUIDetailItem.m
//  MUIKit
//
//  Created by Malcolm Hall on 30/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MUIDetailItem.h"

@implementation UIViewController (MUIDetailItem)

- (id)mui_detailItem{
  //  return objc_getAssociatedObject(self, @selector(mui_detailItem));
    return nil;
}

- (BOOL)mui_canSelectDetailItem:(id)object{
    return NO;
}

- (id)mui_currentDetailItemWithSender:(id)sender
{
    // Look for a view controller that has a visible photo
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_currentDetailItemWithSender:) sender:sender];
    if (target) {
        return [target mui_currentDetailItemWithSender:sender];
    } else {
        return nil;
    }
}

@end


@implementation UINavigationController (MUIDetailItem)

- (BOOL)mui_canSelectDetailItem:(id)object{
    return [self.topViewController mui_canSelectDetailItem:object];
}

- (id)mui_detailItem{
    if([self.topViewController isKindOfClass:UINavigationController.class]){
        return self.topViewController.mui_detailItem;
    }
    else{
        return self.viewControllers.firstObject.mui_detailItem;
    }
}

@end

@implementation UISplitViewController (MUIDetailItem)

- (id)mui_currentDetailItemWithSender:(id)sender
{
    if (self.collapsed) {
        // If we're collapsed, find the detail nav controller
        return self.viewControllers.firstObject.mui_detailItem;
    } else {
        // Otherwise, return our detail controller's contained photo (if any)
        UIViewController *controller = self.viewControllers.lastObject;
        return controller.mui_detailItem;
    }
}

@end
