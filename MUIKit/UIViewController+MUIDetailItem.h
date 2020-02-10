//
//  UIViewController+MUIDetailItem.h
//  MUIKit
//
//  Created by Malcolm Hall on 30/10/2019.
//  Copyright © 2019 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MUIDetailItem)

- (BOOL)mui_containsDetailItem:(id)object;

//- (id)mui_currentVisibleDetailItemWithSender:(id)sender;

- (id)mui_containedDetailItem;

//- (BOOL)mui_canSelectDetailDetailItem:(id)object;

//- (id)mui_currentDetailDetailItemWithSender:(id)sender;

//- (id)mui_detailDetailItem;

//- (void)mui_showDetailDetailViewController:(UIViewController *)vc sender:(id)sender;

//- (UIBarButtonItem *)mui_currentDisplayModeButtonItemWithSender:(id)sender;

@end

@interface UISplitViewController (MUIDetailItem)

//- (id)mui_currentVisibleDetailItem;

@end

NS_ASSUME_NONNULL_END
