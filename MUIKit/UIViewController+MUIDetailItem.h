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

- (BOOL)mui_canSelectDetailItem:(id)object;

- (id)mui_currentDetailItemWithSender:(id)sender;

- (id)mui_detailItem;

@end

NS_ASSUME_NONNULL_END
