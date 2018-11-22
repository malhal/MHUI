//
//  MUILargeDetailSplitter.m
//  MUIKit
//
//  Created by Malcolm Hall on 03/11/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIDetailItemSplitter.h"
#import "UIViewController+MUIDetail.h"
#import "MUISplitViewController.h"

@implementation MUIDetailItemSplitter

- (instancetype)initWithSplitViewController:(MUISplitViewController *)splitController{
    self = [super init];
    if (self) {
        splitController.delegate = self;
        _splitController = splitController;
    }
    return self;
}

// needed because the splitview checks for delegate methods when first set
- (void)setSplitControllerDelegate:(NSObject<UISplitViewControllerDelegate> *)splitControllerDelegate{
    if(splitControllerDelegate == _splitControllerDelegate){
        return;
    }
    self.splitController.delegate = nil;
    _splitControllerDelegate = splitControllerDelegate;
    self.splitController.delegate = self;
}

- (BOOL)respondsToSelector:(SEL)aSelector{
    if([super respondsToSelector:aSelector]){
        return YES;
    }
    if(MHFProtocolHasInstanceMethod(@protocol(UISplitViewControllerDelegate), aSelector)){
        return [self.splitControllerDelegate respondsToSelector:aSelector];
    }
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(MHFProtocolHasInstanceMethod(@protocol(UISplitViewControllerDelegate), aSelector)){
        if([self.splitControllerDelegate respondsToSelector:aSelector]){
            return self.splitControllerDelegate;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}

// needs to push detail onto the root nav controller (not the master).
// Return yes means throw away
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    
    // here we are deciding if the detail should be thrown away or not. Based on if the current controllers contain it.
    
    id detailItem = secondaryViewController.mui_detailItem;
    if(!detailItem){
        // If our secondary controller doesn't show a detail item, do the collapse ourself by doing nothing
        return YES;
    }
    if (![primaryViewController mui_containsDetailItem:detailItem]) {
        return YES;
    }
    return NO;
}

// needs to be called first
// large splitter seperating
- (nullable UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
    if(primaryViewController.mui_detailItem){
        return nil;
    }
    else if(![self.delegate respondsToSelector:@selector(createDetailViewControllerForDetailSplitter:)]){
        return nil;
    }
    return [self.delegate createDetailViewControllerForDetailSplitter:self];
}

@end