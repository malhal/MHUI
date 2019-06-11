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
#import "UIViewController+MUI.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (weak, nonatomic, readwrite, setter=mui_setCollapseControllerForMaster:) MUICollapseController *mui_collapseControllerForMaster;
@property (weak, nonatomic, readwrite, setter=mui_setCollapseControllerForDetail:) MUICollapseController *mui_collapseControllerForDetail;

@end

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
        //NSAssert([splitViewController.viewControllers.firstObject isKindOfClass:MUIRootNavigationController.class], @"Primary must be instance of MUIRootNavigationController");
        splitViewController.delegate = self;
        _splitViewController = splitViewController;
    }
    return self;
}

- (void)setMasterViewController:(UIViewController<MUIMasterCollapsing> *)masterViewController{
    if(masterViewController == _masterViewController){
        return;
    }
    masterViewController.mui_collapseControllerForMaster = self;
    _masterViewController = masterViewController;
}

- (void)setDetailViewController:(UIViewController<MUIDetailCollapsing> *)detailViewController{
    if(detailViewController == _detailViewController){
        return;
    }
    detailViewController.mui_collapseControllerForDetail = self;
    _detailViewController = detailViewController;
}

// we throw away detail if not on the master or the master does not contain the current detail item.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([self.masterViewController mui_isMemberOfViewControllerHierarchy:primaryViewController] && [self.masterViewController containsDetailItem:self.detailViewController.detailItem]){
        return NO;
    }
    return YES;
}

- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    NSLog(@"");
    return nil;
}

@end

@implementation UIViewController (MUICollapseController)

- (MUICollapseController *)mui_collapseControllerForDetail{
    return objc_getAssociatedObject(self, @selector(mui_collapseControllerForDetail));
}

- (void)mui_setCollapseControllerForDetail:(MUICollapseController *)collapseControllerForDetail {
    objc_setAssociatedObject(self, @selector(mui_collapseControllerForDetail), collapseControllerForDetail, OBJC_ASSOCIATION_ASSIGN);
}

- (MUICollapseController *)mui_collapseControllerForMaster{
    return objc_getAssociatedObject(self, @selector(mui_collapseControllerForMaster));
}

- (void)mui_setCollapseControllerForMaster:(MUICollapseController *)collapseControllerForMaster {
    objc_setAssociatedObject(self, @selector(mui_collapseControllerForMaster), collapseControllerForMaster, OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isMemberOfViewControllerHierarchy:(UIViewController *)highViewController{
    UIViewController *vc = self;
    while(vc){
        if(vc == highViewController){
            return YES;
        }
        vc = vc.parentViewController;
    }
    return NO;
}


@end
