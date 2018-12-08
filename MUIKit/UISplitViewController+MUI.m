//
//  UISplitViewController+MUI.m
//  MUIKit
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "UISplitViewController+MUI.h"

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

@end
