//
//  MUIRootNavigationController.m
//  MUIKit
//
//  Created by Malcolm Hall on 08/12/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import "MUIRootNavigationController.h"
#import "UIViewController+MUI.h"

@interface MUIRootNavigationController ()

@end

@implementation MUIRootNavigationController

// prevents pushing when deleting an item in portrait and another is selected. But allows the split to preserve the detail controller.
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    if(![sender isKindOfClass:UIView.class]){
        return;
    }
    [super showViewController:vc sender:sender];
}

@end
