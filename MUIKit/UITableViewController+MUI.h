//
//  UITableViewController+MUI.h
//  MUIKit
//
//  Created by Malcolm Hall on 11/02/2020.
//  Copyright © 2020 Malcolm Hall. All rights reserved.
//
#import <MHFoundation/MHFoundation.h>
#import <UIKit/UIKit.h>
#import <MUIKit/MUIDefines.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewController (MUI)

- (UITableView *)mui_tableViewIfLoaded;

@end

NS_ASSUME_NONNULL_END
