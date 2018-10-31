//
//  UIViewController+MUIShowing.h
//  MUIKit
//
//  Created by Malcolm Hall on 31/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MUIShowing)

// Returns whether calling showViewController:sender: would cause a navigation "push" to occur
- (BOOL)mui_willShowingViewControllerPushWithSender:(id)sender;

// Returns whether calling showDetailViewController:sender: would cause a navigation "push" to occur
- (BOOL)mui_willShowingDetailViewControllerPushWithSender:(id)sender;

@end

NS_ASSUME_NONNULL_END
