//
//  UIViewController+MUI.m
//  WiFiFoFum-Passwords
//
//  Created by Malcolm Hall on 29/09/2016.
//  Copyright © 2016 Malcolm Hall. All rights reserved.
//

#import "UIViewController+MUI.h"
#import "UINavigationItem+MUI.h"
#import <objc/runtime.h>

@implementation UIViewController (MUI)

- (void)mui_setLoading:(BOOL)loading{
    BOOL mui_loading = [objc_getAssociatedObject(self, @selector(mui_loading)) boolValue];
    if(loading == mui_loading){
        return;
    }
    self.view.userInteractionEnabled = !loading;
    self.navigationItem.rightBarButtonItem.enabled = !loading;
    self.navigationItem.hidesBackButton = loading;
    if(loading){
        [self.navigationItem mui_beginTitleRefreshing];
    }else{
        [self.navigationItem mui_endTitleRefreshing];
    }
    NSString* keyPath = NSStringFromSelector(@selector(mui_loading));
    [self willChangeValueForKey:keyPath];
    objc_setAssociatedObject(self, @selector(mui_loading), @(loading), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:keyPath];
}

- (BOOL)mui_loading{
    return [objc_getAssociatedObject(self, @selector(mui_loading)) boolValue];
}

- (BOOL)mui_isViewVisible{
    return self.isViewLoaded && self.view.window;
}

- (void)mui_reloadView{
    UIView *view = self.viewIfLoaded;
    BOOL callAppearanceMethods = self.parentViewController && !self.parentViewController.shouldAutomaticallyForwardAppearanceMethods;
    UIView *superview = view.superview;
    if(callAppearanceMethods){
        [self beginAppearanceTransition:NO animated:NO];
    }
    [view removeFromSuperview];
    if(callAppearanceMethods){
        [self endAppearanceTransition];
    }
    self.view = nil;
    view = self.view;
    // workaround for nav controller and tab controller not forwarding viewWillAppear
    if(callAppearanceMethods){
        [self beginAppearanceTransition:YES animated:NO];
    }
    [superview addSubview:view];
    if(callAppearanceMethods){
        [self endAppearanceTransition];
    }
}

+ (__kindof UIViewController *)mui_viewControllerForView:(UIView *)view{
    // doesn't work on UITableViewCell
    return [view valueForKey:@"_viewDelegate"];
}

@end

@implementation UIViewController (MUIDetailItemContents)

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

@implementation UISplitViewController (MUIDetailItemContents)

- (id)mui_currentVisibleDetailItemWithSender:(id)sender
{
    if (self.collapsed) {
        // If we're collapsed, we don't have a detail
        return nil;
    } else {
        // Otherwise, return our detail controller's contained photo (if any)
        UIViewController *controller = [self.viewControllers lastObject];
        return [controller mui_detailItem];
        //return [controller mui_currentVisibleDetailItemWithSender:sender]; // maybe odd we call this on a nav controller that just said it couldn't perform the action.
    }
}

@end

@implementation UINavigationController (MUIDetailItemContents)

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

@end


@implementation UIViewController (MUIViewControllerShowing)

- (BOOL)mui_willShowingViewControllerPushWithSender:(id)sender
{
    // Find and ask the right view controller about showing
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_willShowingViewControllerPushWithSender:) sender:sender];
    if (target) {
        return [target mui_willShowingViewControllerPushWithSender:sender];
    } else {
        // Or if we can't find one, we won't be pushing
        return NO;
    }
}

- (BOOL)mui_willShowingDetailViewControllerPushWithSender:(id)sender
{
    // Find and ask the right view controller about showing detail
    UIViewController *target = [self targetViewControllerForAction:@selector(mui_willShowingDetailViewControllerPushWithSender:) sender:sender];
    if (target) {
        return [target mui_willShowingDetailViewControllerPushWithSender:sender];
    } else {
        // Or if we can't find one, we won't be pushing
        return NO;
    }
}

@end

@implementation UINavigationController (MUIViewControllerShowing)

- (BOOL)mui_willShowingViewControllerPushWithSender:(id)sender
{
    // Navigation Controllers always push for showViewController:
    return YES;
}

@end

@implementation UISplitViewController (MUIViewControllerShowing)

- (BOOL)mui_willShowingViewControllerPushWithSender:(id)sender
{
    // Split View Controllers never push for showViewController:
    return NO;
}

- (BOOL)mui_willShowingDetailViewControllerPushWithSender:(id)sender
{
    if (self.collapsed) {
        // If we're collapsed, re-ask this question as showViewController: to our primary view controller
        UIViewController *target = [self.viewControllers lastObject];
        return [target mui_willShowingViewControllerPushWithSender:sender];
    } else {
        // Otherwise, we don't push for showDetailViewController:
        return NO;
    }
}

@end
