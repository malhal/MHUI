//
//  MUIMasterDetailController.m
//  RootMUIMasterDetail
//
//  Created by Malcolm Hall on 10/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIMasterDetailController.h"
#import <objc/runtime.h>

NSString * const MUIMasterDetailControllerDetailItemDidChange = @"MUIMasterDetailControllerDetailItemDidChange";

@implementation MUIMasterDetailController

- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController{
    self = [super init];
    if (self) {
        splitViewController.delegate = self;
        splitViewController.masterDetailController = self;
        _splitViewController = splitViewController;
    }
    return self;
}

- (void)setMasterViewController:(UIViewController<MUIDetailItemSelecting> *)masterViewController{
    if(masterViewController == _masterViewController){
        return;
    }
    masterViewController.masterDetailController = self;
    _masterViewController = masterViewController;
}

- (void)setDetailItem:(NSObject *)detailItem{
    if(detailItem == _detailItem){
        return;
    }
    _detailItem = detailItem;
    NSNotification *notification = [NSNotification notificationWithName:MUIMasterDetailControllerDetailItemDidChange object:self userInfo:detailItem ? @{@"DetailItem" : detailItem} : nil];
  [NSNotificationQueue.defaultQueue enqueueNotification:notification postingStyle:NSPostASAP];
  //  dispatch_async(dispatch_get_main_queue(), ^{
        
    
  //  [NSNotificationCenter.defaultCenter postNotificationName:MUIMasterDetailControllerDetailItemDidChange object:self userInfo:@{@"DetailItem" : detailItem}];
    //    });
}

// we throw away detail if not on the master or the master does not contain the current detail item.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([primaryViewController.childViewControllers containsObject:self.masterViewController] && [self.masterViewController canSelectDetailItem:self.detailItem]){
        return NO;
    }
    return YES;
}

@end

@implementation UIViewController (MUIMasterDetailController)

- (MUIMasterDetailController *)masterDetailController{
    MUIMasterDetailController *mdc = objc_getAssociatedObject(self, @selector(masterDetailController));
    if(!mdc){
        return self.splitViewController.masterDetailController;
    }
    return mdc;
}

- (void)setMasterDetailController:(id)masterDetailController {
    objc_setAssociatedObject(self, @selector(masterDetailController), masterDetailController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


