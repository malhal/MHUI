//
//  NavigationController.m
//  MUIFetchedMasterDetail
//
//  Created by Malcolm Hall on 03/09/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import "MUIMasterNavigationController.h"
#import "UIViewController+MUI.h"

@interface MUIMasterNavigationController ()

@end

@implementation MUIMasterNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// maybe this could look for a navigation controller and replace it
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
//    if(self.viewControllers.count > 1){
//        if([sender isKindOfClass:UIView.class] || [sender isKindOfClass:UIViewController.class]){
//            UIViewController *child = [self mui_childContainingSender:sender];
//            if(child && self.topViewController != child){
//                [UIView performWithoutAnimation:^{
//                    [self popToViewController:child animated:NO];
//                    [super showViewController:vc sender:sender];
//                }];
//                return;
//            }
//        }
//    }
    UIViewController *vcBeforeNav;
    for(UIViewController *child in self.childViewControllers){
        if([child isKindOfClass:UINavigationController.class] && vcBeforeNav){
            [UIView performWithoutAnimation:^{
                [self popToViewController:vcBeforeNav animated:NO];
                [super showViewController:vc sender:sender];
            }];
            return;
        }
        vcBeforeNav = child;
    }
    [super showViewController:vc sender:sender];
}

- (UIViewController *)separateSecondaryViewControllerForSplitViewController:(UISplitViewController *)splitViewController{
    //UIViewController *vc = [super separateSecondaryViewControllerForSplitViewController:splitViewController];
    if(![self.topViewController isKindOfClass:UINavigationController.class]){
        return nil;
    }
    return [super separateSecondaryViewControllerForSplitViewController:splitViewController];
}

// overriding this causes the class not to be found.
//- (nullable UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(nullable NSString *)identifier{
//    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];
//}

@end
