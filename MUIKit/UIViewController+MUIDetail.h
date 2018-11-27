//
//  UIViewController+MUIDetail.h
//  MUIKit
//
//  Created by Malcolm Hall on 31/10/2018.
//  Copyright © 2018 Malcolm Hall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (MUIDetail)

- (id)mui_masterItem;

- (id)mui_detailItem;

- (BOOL)mui_containsDetailItem:(id)detailItem;

- (BOOL)mui_containsMasterItem:(id)masterItem;



- (id)mui_currentVisibleDetailItemWithSender:(id)sender;

@end

NS_ASSUME_NONNULL_END
