//
//  SecondaryItemController.m
//  MUIKit
//
//  Created by Malcolm Hall on 05/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUISecondaryItemController.h"
#import <objc/runtime.h>

NSString * const MUISecondaryItemControllerItemDidChangeNotification = @"MUISecondaryItemControllerItemDidChangeNotification";

@implementation MUISecondaryItemController

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController{
    self = [super init];
    if (self) {
        splitViewController.secondaryItemController = self;
        splitViewController.delegate = self;
        _splitViewController = splitViewController;
    }
    return self;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if(self.item){
        return NO;
    }
    return YES;
}

- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    if(self.item){
        return nil;
    }
    return [UIViewController.alloc init];
}

- (void)setItem:(id)item{
    if(item == _item){
        return;
    }
    _item = item;
    [NSNotificationCenter.defaultCenter postNotificationName:MUISecondaryItemControllerItemDidChangeNotification object:self];
}

@end

@implementation UISplitViewController (MUISecondaryItemController)

- (MUISecondaryItemController *)secondaryItemController{
    return objc_getAssociatedObject(self, @selector(secondaryItemController));
}

- (void)setSecondaryItemController:(MUISecondaryItemController *)objectContext {
    objc_setAssociatedObject(self, @selector(secondaryItemController), objectContext, OBJC_ASSOCIATION_ASSIGN);
}

@end
