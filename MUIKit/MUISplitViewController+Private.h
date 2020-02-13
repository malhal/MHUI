//
//  MUISplitViewController+Private.h
//  MUIKit
//
//  Created by Malcolm Hall on 11/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//

#import "MUISplitViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MUISplitViewController (Private)

- (void)viewControllerUpdatedDetailModelIdentifier:(UIViewController *)vc;

@end

@interface UIViewController (MUISplitViewController)

@property (weak, nonatomic, setter=mui_setDetailShowingViewController:) MUISplitViewController *mui_detailShowingViewController;

//@property (copy, nonatomic, readwrite, setter=mui_setCurrentDetailModelIdentifier:) NSString *mui_currentDetailModelIdentifier;

@property (strong, nonatomic, readonly) UIViewController *mui_detailShownViewController;

- (void)mui_viewControllerUpdatedDetailModelIdentifier:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END
