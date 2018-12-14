//
//  MUIMasterDetailContext.m
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIMasterDetailContext.h"
#import <objc/runtime.h>
#import "MUIPrimaryNavigationController.h"

//NSString * const MUIMasterDetailContextDetailItemDidChange = @"MUIMasterDetailContextDetailItemDidChange";

@implementation MUIMasterDetailContext

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
        NSAssert([splitViewController.viewControllers.firstObject isKindOfClass:MUIPrimaryNavigationController.class], @"Primary must be instance of MUIPrimaryNavigationController");
        //splitViewController.masterDetailContext = self;
        splitViewController.delegate = self;
        _splitViewController = splitViewController;   
    }
    return self;
}

- (void)setMasterViewController:(UIViewController<MUIMasterViewControlling> *)masterViewController{
    if(masterViewController == _masterViewController){
        return;
    }
    masterViewController.masterDetailContext = self;
    _masterViewController = masterViewController;
}

- (void)setDetailViewController:(UIViewController<MUIDetailViewControlling> *)detailViewController{
    if(detailViewController == _detailViewController){
        return;
    }
    detailViewController.masterDetailContext = self;
    _detailViewController = detailViewController;
}

//- (void)setDetailItem:(id)detailItem{
//    if(detailItem == _detailItem){
//        return;
//    }
//    _detailItem = detailItem;
    //NSNotification *notification = [NSNotification notificationWithName:MUIMasterDetailContextDetailItemDidChange object:self userInfo:detailItem ? @{@"DetailItem" : detailItem} : nil];
  //  [NSNotificationQueue.defaultQueue enqueueNotification:notification postingStyle:NSPostASAP];
  //  dispatch_async(dispatch_get_main_queue(), ^{
        
    
  //  [NSNotificationCenter.defaultCenter postNotificationName:MUIMasterDetailContextDetailItemDidChange object:self userInfo:@{@"DetailItem" : detailItem}];
    //    });
//}

// we throw away detail if not on the master or the master does not contain the current detail item.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([primaryViewController.childViewControllers containsObject:self.masterViewController] && [self.masterViewController canSelectDetailItem:self.detailViewController.detailItem]){
        return NO;
    }
    return YES;
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    
//    return nil;
//}

@end

//@implementation UISplitViewController (MUIMasterDetailContext)
//
//- (MUIMasterDetailContext *)masterDetailContext{
//    return objc_getAssociatedObject(self, @selector(masterDetailContext));
//}
//
//- (void)setMasterDetailContext:(id)masterDetailContext {
//    objc_setAssociatedObject(self, @selector(masterDetailContext), masterDetailContext, OBJC_ASSOCIATION_ASSIGN);
//}
//
//@end
