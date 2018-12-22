//
//  MUICollapseController.m
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//
// MUISplitCollapseController or MUICollapseController

#import "MUICollapseController.h"
#import <objc/runtime.h>
#import "MUIPrimaryNavigationController.h"
#import "UIViewController+MUI.h"

@implementation MUICollapseController

- (id<UIStateRestoring>)restorationParent{
    return self.splitViewController;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.masterViewController forKey:@"MasterViewController"];
 //   [coder encodeObject:self.detailItem forKey:@"DetailItem"];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
    self.masterViewController = [coder decodeObjectForKey:@"MasterViewController"];
  //  self.detailItem = [coder decodeObjectForKey:@"DetailItem"];
}

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController{
    self = [super init];
    if (self) {
        //NSAssert([splitViewController.viewControllers.firstObject isKindOfClass:MUIPrimaryNavigationController.class], @"Primary must be instance of MUIPrimaryNavigationController");
        splitViewController.delegate = self;
        _splitViewController = splitViewController;   
    }
    return self;
}

- (void)setMasterViewController:(UIViewController<MUIMasterCollapsing> *)masterViewController{
    if(masterViewController == _masterViewController){
        return;
    }
    masterViewController.masterCollapseController = self;
    _masterViewController = masterViewController;
}

- (void)setDetailViewController:(UIViewController<MUIDetailCollapsing> *)detailViewController{
    if(detailViewController == _detailViewController){
        return;
    }
    detailViewController.detailCollapseController = self;
    _detailViewController = detailViewController;
}

// we throw away detail if not on the master or the master does not contain the current detail item.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([self.masterViewController mui_isMemberOfViewControllerHierarchy:primaryViewController] && [self.masterViewController containsDetailItem:self.detailViewController.detailItem]){
        return NO;
    }
    return YES;
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    return nil;
//}

@end
