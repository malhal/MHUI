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
#import "MUISplitViewController.h"
#import "UIViewController+MUIDetailItem.h"

@interface UISplitViewController ()

//@property (strong, nonatomic, readwrite, setter=mui_setCurrentSplitDetailItem:) MUISplitDetailItem *mui_currentSplitDetailItem;

//@property (strong, nonatomic, readwrite, setter=mui_setDetailViewController:) UIViewController *mui_detailViewController;

@end

@interface UIViewController ()

//@property (weak, nonatomic, readwrite, setter=mui_setCollapseControllerForMaster:) MUICollapseController *mui_collapseControllerForMaster;
//@property (weak, nonatomic, readwrite, setter=mui_setCollapseControllerForDetail:) MUICollapseController *mui_collapseControllerForDetail;

@end

//@implementation MUISplitDetailItem
//
//@end

@implementation MUICollapseController

//- (id<UIStateRestoring>)restorationParent{
//    return self.splitViewController;
//}
//
//- (void)encodeRestorableStateWithCoder:(NSCoder *)coder{
//    [coder encodeObject:self.masterViewController forKey:@"MasterViewController"];
// //   [coder encodeObject:self.detailItem forKey:@"DetailItem"];
//}
//
//- (void)decodeRestorableStateWithCoder:(NSCoder *)coder{
//    self.masterViewController = [coder decodeObjectForKey:@"MasterViewController"];
//  //  self.detailItem = [coder decodeObjectForKey:@"DetailItem"];
//}


- (instancetype)initWithSplitViewController:(UISplitViewController *)splitViewController{
    self = [super init];
    if (self) {
        //NSAssert([splitViewController.viewControllers.firstObject isKindOfClass:MUIRootNavigationController.class], @"Primary must be instance of MUIRootNavigationController");
        splitViewController.delegate = self;
        _splitViewController = splitViewController;
        NSAssert(splitViewController.viewControllers.count == 2, @"splitViewController must have 2 child view controllers");
        //splitViewController.mui_currentSplitDetailItem = splitViewController.viewControllers[1].mui_splitDetailItem;
       // splitViewController.mui_detailViewController = splitViewController.viewControllers[1];
    }
    return self;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender{
    //splitViewController.mui_currentSplitDetailItem = vc.mui_splitDetailItem;
    //splitViewController.mui_detailViewController = vc;
    return NO;
}

// we throw away detail if not on the master or the master does not contain the current detail item.
- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
//    if ([self.masterViewController mui_isMemberOfViewControllerHierarchy:primaryViewController] && [self.masterViewController containsDetailItem:self.detailViewController.detailItem]){
//        return NO;
//    }
//    return YES;
    
    
    //return NO;
    id object = secondaryViewController.mui_detailItem;
    if (!object) {
        // If our secondary controller doesn't show a photo, do the collapse ourself by doing nothing
        return YES;
    }
    // check in reverse if there are any that can select it
    //BOOL b = YES;
    // Before collapsing, remove any view controllers on our stack that don't match the photo we are about to merge on
    ///if ([primaryViewController isKindOfClass:[UINavigationController class]]) {
        //NSMutableArray *viewControllers = [NSMutableArray array];
//        for (UIViewController *controller in [(UINavigationController *)primaryViewController viewControllers]) {
//            if (![controller aapl_canSelectPhoto:photo]) {
//                //[viewControllers addObject:controller];
//                return YES;
//            }
//        }
 //       UINavigationController *pcn = (UINavigationController *)primaryViewController;
        
        //if(pcn.viewControllers.lastObject.aapl_containedPhoto == photo)
        
    else if(![primaryViewController mui_canSelectDetailItem:object]){
        return YES;
    }
        
//        for (UIViewController *controller in pcn.viewControllers.reverseObjectEnumerator) {
//             if (![controller aapl_canSelectPhoto:photo]) {
//                 //[viewControllers addObject:controller];
//                 //b = NO;
//                  return YES;
//             }
//         }
        
        //[(UINavigationController *)primaryViewController setViewControllers:viewControllers];
  //  }
    //return b;
    return NO;
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController{
//    NSLog(@"");
//    return nil;
//}

@end

@implementation UIViewController (MUICollapseController)

@end

@implementation UISplitViewController (MUICollapseController)



//- (UIViewController *)mui_detailViewController{
//    return objc_getAssociatedObject(self, @selector(mui_detailViewController));
//}
//
//- (void)mui_setDetailViewController:(UIViewController *)detailViewController {
//    objc_setAssociatedObject(self, @selector(mui_detailViewController), detailViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}



@end
