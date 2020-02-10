//
//  UISplitViewController+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UISplitViewController+MUI.h"
#import <objc/runtime.h>

NSString * const MUIViewControllerDetailItemDidChange = @"MUIViewControllerDetailItemDidChange";

@implementation UISplitViewController (MUI)

- (UIViewController *)mui_secondaryViewController{
    NSArray *viewControllers = self.viewControllers;
    if(viewControllers.count != 2){
        return nil;
    }
    return viewControllers[1];
}

- (UINavigationController *)mui_secondaryNavigationController{
    return MHFDynamicCast(UINavigationController.class, self.mui_secondaryViewController);
}

//- (id)mui_detailItem{
//    return objc_getAssociatedObject(self, @selector(mui_detailItem));
//}
//
//- (void)mui_setDetailItem:(id)detailItem {
//    objc_setAssociatedObject(self, @selector(mui_detailItem), detailItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [NSNotificationCenter.defaultCenter postNotificationName:MUIViewControllerDetailItemDidChange object:self userInfo:nil];
//}

@end
